/*****************************************************************************
 * Copyright by The HDF Group.                                               *
 * Copyright by the Board of Trustees of the University of Illinois.         *
 * All rights reserved.                                                      *
 *                                                                           *
 * This file is part of the HDF Java Products distribution.                  *
 * The full copyright notice, including terms governing use, modification,   *
 * and redistribution, is contained in the files COPYING and Copyright.html. *
 * COPYING can be found at the root of the source code distribution tree.    *
 * Or, see http://hdfgroup.org/products/hdf-java/doc/Copyright.html.         *
 * If you do not have access to either file, you may request a copy from     *
 * help@hdfgroup.org.                                                        *
 ****************************************************************************/

package kr.co.indisystem.util;

import java.awt.BorderLayout;
import java.io.File;
import java.lang.reflect.Array;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.swing.BorderFactory;
import javax.swing.JPanel;
import javax.swing.tree.DefaultMutableTreeNode;

import ncsa.hdf.object.Attribute;
import ncsa.hdf.object.CompoundDS;
import ncsa.hdf.object.Dataset;
import ncsa.hdf.object.Datatype;
import ncsa.hdf.object.FileFormat;
import ncsa.hdf.object.Group;
import ncsa.hdf.object.HObject;
import ncsa.hdf.object.ScalarDS;
import ncsa.hdf.object.h5.H5File;
import ncsa.hdf.view.ViewProperties;

/**
 * DefaultMetadataView is an dialog window used to show data properties.
 * Data properties include attributes and general information such as
 * object type, data type and data space.
 *    
 * @author Peter X. Cao
 * @version 2.4 9/6/2007
 */
public class MetaDataUtil{

    /** The HDF data object */
    private HObject hObject;
    private int numAttributes;
    private boolean isH5, isH4;
    
    private String xmlData;
    
    
    public static void mainX(String[] args) throws Exception {

		String filename = "mtsat1r_jami_hrit_zzz_f_200901020733.h5";
		H5File file = new H5File(filename, H5File.READ);
		HObject obj = file.get("/Image/Geostationary/DK01IR1");

		MetaDataUtil t = new MetaDataUtil(obj);
		t.getXml();
		
		//general, attributes
		
	}
    public String getXml(){
    	return "<root>\n" + xmlData + "</root>\n";
    }

    /**
     * Constructs a DefaultMetadataView with the given HDFView.
     */
    public MetaDataUtil(HObject obj) {

        hObject = obj;
        numAttributes = 0;
        
        StringBuffer xml = new StringBuffer(1024);

        if (hObject == null) {
        	//to do
        } else if ( hObject.getPath()== null) {
            xml.append("\t<Properties>"+hObject.getName()+"</Properties>\n");
        } else {
            xml.append("\t<Properties>"+hObject.getPath()+hObject.getName()+"</Properties>\n");
        }

        isH5 = hObject.getFileFormat().isThisType(FileFormat.getFileFormat(FileFormat.FILE_TYPE_HDF5));
        isH4 = hObject.getFileFormat().isThisType(FileFormat.getFileFormat(FileFormat.FILE_TYPE_HDF4));

        // get the metadata information before add GUI components */
        try { hObject.getMetadata(); } catch (Exception ex) {}
        xml.append(createGeneralPropertyPanel());
        xml.append(createAttributePanel());
        boolean isRoot = ((hObject instanceof Group) && ((Group)hObject).isRoot());
        if (isH5 && isRoot)
        {
            // add panel to display user block
            //tabbedPane.addTab("User Block", createUserBlockPanel());
        } 
        
        xmlData = xml.toString();
    }   

    /** returns the data object displayed in this data viewer */
    public HObject getDataObject() {
        return hObject;
    }  

    
    /**
     * Creates a panel used to dispaly general information of HDF object.
     */
    private String createGeneralPropertyPanel()
    {
        JPanel panel = new JPanel();
        panel.setLayout (new BorderLayout(10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(10,0,0,0));
        boolean isRoot = ((hObject instanceof Group) && ((Group)hObject).isRoot());
        FileFormat theFile = hObject.getFileFormat();
        
        Map keyMap = new HashMap();
        Map valueMap = new HashMap();
        if (isRoot)
        {
        	keyMap.put("field1", "FileName");
        	keyMap.put("field2", "FilePath");
        	keyMap.put("field3", "FileType");
        }
        else
        {
        	keyMap.put("field1", "Name");
        	keyMap.put("field2", "Path");
        	keyMap.put("field3", "Type");      	
            
            /* bug #926 to remove the OID, put it back on Nov. 20, 2008, --PC */
            if (isH4) {
            	keyMap.put("field4", "TagRef");  
            } else {
            	keyMap.put("field4", "ObjectRef");  
            }
        }

        valueMap.put("field1", hObject.getName());

        if (isRoot) {
        	valueMap.put("field2", (new File(hObject.getFile())).getParent());
        } else {
        	valueMap.put("field2", hObject.getPath());
        }

        String typeStr = "Unknown";
        String fileInfo = "";
        if (isRoot)
        {
            long size = 0;
            try { size = (new File(hObject.getFile())).length(); }
            catch (Exception ex) { size = -1; }
            size /= 1024;

            int groupCount=0, datasetCount=0;
            DefaultMutableTreeNode root = (DefaultMutableTreeNode)theFile.getRootNode();
            DefaultMutableTreeNode theNode = null;
            Enumeration local_enum = root.depthFirstEnumeration();
            while(local_enum.hasMoreElements())
            {
                theNode = (DefaultMutableTreeNode)local_enum.nextElement();
                if (theNode.getUserObject() instanceof Group) {
                    groupCount++;
                } else {
                    datasetCount++;
                }
            }
            fileInfo = "size="+size+"K,  groups="+groupCount+ ",  datasets="+datasetCount;
        }

        if (isRoot)
        {
            if (isH5) {
                typeStr = "HDF5,  "+fileInfo;
            } else if (isH4) {
                typeStr = "HDF4,  "+fileInfo;
            } else {
                typeStr = fileInfo;
            }
        }
        else if (isH5)
        {
            if (hObject instanceof Group) {
                typeStr = "HDF5 Group";
            } else if (hObject instanceof ScalarDS) {
                typeStr = "HDF5 Scalar Dataset";
            } else if (hObject instanceof CompoundDS) {
                typeStr = "HDF5 Compound Dataset";
            } else if (hObject instanceof Datatype) {
                typeStr = "HDF5 Named Datatype";
            }
        }
        else if (isH4)
        {
            if (hObject instanceof Group) {
                typeStr = "HDF4 Group";
            } else if (hObject instanceof ScalarDS)
            {
                ScalarDS ds = (ScalarDS)hObject;
                if (ds.isImage()) {
                    typeStr = "HDF4 Raster Image";
                } else {
                    typeStr = "HDF4 SDS";
                }
            }
            else if (hObject instanceof CompoundDS) {
                typeStr = "HDF4 Vdata";
            }
        }
        else
        {
            if (hObject instanceof Group) {
                typeStr = "Group";
            } else if (hObject instanceof ScalarDS)
            {
                ScalarDS ds = (ScalarDS)hObject;
                typeStr = "Scalar Dataset";
            }
            else if (hObject instanceof CompoundDS) {
                typeStr = "Compound Dataset";
            }
        }
        valueMap.put("field3", typeStr);

        /* bug #926 to remove the OID, put it back on Nov. 20, 2008, --PC */
        String oidStr = null;
        long[] OID = hObject.getOID();
        if (OID != null)
        {
            oidStr = String.valueOf(OID[0]);
            for (int i=1; i<OID.length; i++) {
                oidStr += ", "+ OID[i];
            }
        }       
         
        if (!isRoot) {
            valueMap.put("field4", oidStr);
        }else{
        	valueMap.put("field4", "");
        }
        
        
        //xml parsing
        StringBuffer childXML = new StringBuffer();
        Iterator iter = keyMap.keySet().iterator();
        while(iter.hasNext()){
        	String key = (String)iter.next();
        	String xmlName = (String)keyMap.get(key);
        	childXML.append("\t\t<"+xmlName+">"+valueMap.get(key)+"</"+xmlName+">\n");
        }
        
        
        if (hObject instanceof Group) {
        	childXML.append( createGroupInfoPanel((Group)hObject) );
        } else if (hObject instanceof Dataset) {
        	childXML.append( createDatasetInfoPanel((Dataset)hObject) );
        } else if (hObject instanceof Datatype) {
        	childXML.append( createNamedDatatypeInfoPanel((Datatype)hObject) );
        } 
        return "\t<General>\n" + childXML.toString() + "\t</General>\n";
    }

    /**
     * Creates a panel used to display HDF group information.
     */
    private String createGroupInfoPanel(Group g)
    {
        List mlist = g.getMemberList();
        if (mlist == null) {
            return "";
        }

        int n = mlist.size();
        if (n<=0) {
            return "";
        }

        String rowData[][] = new String[n][2];
        for (int i=0; i<n; i++)
        {
            HObject theObj = (HObject)mlist.get(i);
            rowData[i][0] = theObj.getName();
            if (theObj instanceof Group) {
                rowData[i][1] = "Group";
            } else if (theObj instanceof Dataset) {
                rowData[i][1] = "Dataset";
            }
        }
        
        StringBuffer childXML = new StringBuffer();
        childXML.append("\t<groupMember>\n");
        if (g.getNumberOfMembersInFile() < ViewProperties.getMaxMembers()) {
        	childXML.append("\t\t<numberOfMembers>"+n+"</numberOfMembers>\n");
        } else {
        	childXML.append("\t\t<numberOfMembers>"+n+
        			" (in memory), "+g.getNumberOfMembersInFile()+" (in file)</numberOfMembers>\n");
        }
        for(int i = 0; i < rowData.length; i++){
        	childXML.append("\t\t<member>\n");
    		childXML.append("\t\t\t<name>"+rowData[i][0]+"</name>\n");
    		childXML.append("\t\t\t<type>"+rowData[i][1]+"</type>\n");
        	childXML.append("\t\t</member>\n");
        }
        childXML.append("\t</groupMember>\n");
        return childXML.toString();
    }

    private String createNamedDatatypeInfoPanel(Datatype t){
        return "<NamedDatatypeInfo>"+t.getDatatypeDescription()+"</NamedDatatypeInfo>\n";
    }

    /**
     * Creates a panel used to display HDF dataset information.
     */
    private String createDatasetInfoPanel(Dataset d)
    {      

        if (d.getRank() <= 0) {
            d.init();
        }  
        
        StringBuffer childXML = new StringBuffer();
        childXML.append("\t\t\t<NoOfDimensions>"+d.getRank()+"</NoOfDimensions>\n");

        String dimStr = null;
        String maxDimStr = null;
        long dims[] = d.getDims();
        long maxDims[] = d.getMaxDims();
        if (dims != null)
        {
            String[] dimNames = d.getDimNames();
            boolean hasDimNames = ((dimNames!=null) && (dimNames.length == dims.length));
            StringBuffer sb = new StringBuffer();
            StringBuffer sb2 = new StringBuffer();
            
            sb.append(dims[0]);
            if (hasDimNames) {
                sb.append(" (");
                sb.append(dimNames[0]);
                sb.append(")");
            }
            
            if (maxDims[0] < 0)
                sb2.append("Unlimited");
            else
                sb2.append(maxDims[0]);

            for (int i=1; i<dims.length; i++)
            {
                sb.append(" x ");
                sb.append(dims[i]);
                if (hasDimNames) {
                    sb.append(" (");
                    sb.append(dimNames[i]);
                    sb.append(")");
                }
                
                sb2.append(" x ");
                if (maxDims[i] < 0)
                    sb2.append("Unlimited");
                else
                    sb2.append(maxDims[i]);

            }
            dimStr = sb.toString();
            maxDimStr = sb2.toString();
        }       
        
       
        String typeStr = null;
        if (d instanceof ScalarDS)
        {
            ScalarDS sd = (ScalarDS)d;
            typeStr = sd.getDatatype().getDatatypeDescription();
        } else if (d instanceof CompoundDS)
        {
            if (isH4) {
                typeStr = "Vdata";
            } else {
                typeStr = "Compound";
            }
        }
        childXML.append("\t\t\t<DimensionSize>"+dimStr+"</DimensionSize>\n");
        childXML.append("\t\t\t<MaxDimensionSize>"+maxDimStr+"</MaxDimensionSize>\n");
        childXML.append("\t\t\t<DataType>"+typeStr+"</DataType>\n");
        //childXML.append("<DataspaceAndDatatype>"+typeStr+"</DataspaceAndDatatype>");        

        // add compound datatype information
        if (d instanceof CompoundDS)
        {
            CompoundDS compound = (CompoundDS)d;

            int n = compound.getMemberCount();
            if (n > 0)
            {
            	childXML.append("\t\t\t\t<compoundDatatype>\n");
                String rowData[][] = new String[n][3];
                String names[] = compound.getMemberNames();
                Datatype types[] = compound.getMemberTypes();
                int orders[] = compound.getMemberOrders();
                System.out.println("################# "+names);System.out.flush();
                System.out.println("################# "+types);System.out.flush();
                System.out.println("################# "+orders);System.out.flush();

                for (int i=0; i<n; i++)
                {
                    rowData[i][0] = names[i];
                    int mDims[] = compound.getMemeberDims(i);
                    if (mDims == null) {
                    	rowData[i][2] = String.valueOf(orders[i]);
                    	
                    	if (isH4 && types[i].getDatatypeClass()==Datatype.CLASS_STRING) {
                    		rowData[i][2] = String.valueOf(types[i].getDatatypeSize());
                    	}
                    } else {
                        String mStr = String.valueOf(mDims[0]);
                        int m = mDims.length;
                        for (int j=1; j<m; j++) {
                            mStr +=" x "+mDims[j];
                        }
                        rowData[i][2] = mStr;
                    }
                    rowData[i][1] = types[i].getDatatypeDescription();
                }
                for(int i = 0; i < rowData.length; i++){
                	childXML.append("\t\t\t\t\t<data>\n");
                	childXML.append("\t\t\t\t\t\t<Name>"+rowData[i][0]+"</Name>\n");
                	childXML.append("\t\t\t\t\t\t<Type>"+rowData[i][1]+"</Type>\n");
                	childXML.append("\t\t\t\t\t\t<ArraySize>"+rowData[i][2]+"</ArraySize>\n");
                	childXML.append("\t\t\t\t\t<data>\n");
                }
                childXML.append("\t\t\t\t</compoundDatatype>\n");                
            } // if (n > 0)
        } // if (d instanceof Compound)

        // add compression and data lauoyt information
        //try { d.getMetadata(); } catch (Exception ex) {}
        String chunkInfo = "";
        long[] chunks = d.getChunkSize();
        if (chunks == null) {
            chunkInfo = "NONE";
        } else
        {
            int n = chunks.length;
            chunkInfo = String.valueOf(chunks[0]);
            for (int i=1; i<n; i++)
            {
                chunkInfo += " X " + chunks[i];
            }
        }
               
        Object fillValue = null;
        String fillValueInfo = "NONE";
        if (d instanceof ScalarDS)
            fillValue = ((ScalarDS)d).getFillValue();
        if (fillValue != null) {
            if (fillValue.getClass().isArray()) {
                int len = Array.getLength(fillValue);
                fillValueInfo = Array.get(fillValue, 0).toString();
                for (int i=1; i<len; i++) {
                    fillValueInfo += ", ";
                    fillValueInfo += Array.get(fillValue, i).toString();
                }
            }
            else fillValueInfo = fillValue.toString();
        }
        childXML.append("\t\t\t<Chunking>"+chunkInfo+"</Chunking>\n");    
        childXML.append("\t\t\t<Compression>"+chunkInfo+"</Compression>\n");    
        childXML.append("\t\t\t<FillValue>"+chunkInfo+"</FillValue>\n");       

        return "\t\t<DataspaceAndDatatype>\n" + childXML.toString() + "\t\t</DataspaceAndDatatype>\n";
    }

    /**
     * Creates a panel used to display attribute information.
     */
    private String createAttributePanel()
    {
        List attrList = null;

        try {
            attrList = hObject.getMetadata();
        } catch (Exception ex) {
             attrList = null;
        }
        if (attrList != null) {
            numAttributes = attrList.size();
        }

        if (attrList == null) {
            return "";
        }
        
        StringBuffer childXML = new StringBuffer();
        Attribute attr = null;
        String name, type, size;
        //childXML.append("\t\t<NumberOfAttributes>"+numAttributes+"</NumberOfAttributes>\n");
        for (int i=0; i<numAttributes; i++)
        {
            attr = (Attribute)attrList.get(i);
            name = attr.getName();

            boolean isUnsigned = false;
            type = attr.getType().getDatatypeDescription();
            isUnsigned = attr.getType().isUnsigned();

            long dims[] = attr.getDataDims();
            size = String.valueOf(dims[0]);
            for (int j=1; j<dims.length; j++) {
                size += " x " + dims[j];
            }            
            
            childXML.append("\t\t<Attribute>\n");
        	childXML.append("\t\t\t<Name>"+name+"</Name>\n");
        	childXML.append("\t\t\t<Value>"+attr.toString(", ")+"</Value>\n");
        	childXML.append("\t\t\t<Type>"+type+"</Type>\n");
        	childXML.append("\t\t\t<ArraySize>"+size+"</ArraySize>\n");
        	childXML.append("\t\t</Attribute>\n");
        	
        }  //for (int i=0; i<n; i++)      

        return "\t<Attributes NumberOfAttributes='"+numAttributes+"'>\n" + childXML.toString() +"\t</Attributes>\n";
    }  

}
