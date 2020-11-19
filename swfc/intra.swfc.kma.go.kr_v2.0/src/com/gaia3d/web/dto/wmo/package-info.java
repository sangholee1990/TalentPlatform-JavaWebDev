@XmlSchema(
    namespace = "http://www.isotc211.org/2005/gmd",
    xmlns = {
          @XmlNs(prefix = "gmd", namespaceURI = "http://www.isotc211.org/2005/gmd"), 
          @XmlNs(prefix = "xsi", namespaceURI = "http://www.w3.org/2001/XMLSchema-instance"), 
          @XmlNs(prefix = "gco", namespaceURI = "http://www.isotc211.org/2005/gco"), 
          @XmlNs(prefix = "gts", namespaceURI = "http://www.isotc211.org/2005/gts"), 
          @XmlNs(prefix = "gsr", namespaceURI = "http://www.isotc211.org/2005/gsr"), 
          @XmlNs(prefix = "gss", namespaceURI = "http://www.isotc211.org/2005/gss"), 
          @XmlNs(prefix = "gmx", namespaceURI = "http://www.isotc211.org/2005/gmx"), 
          @XmlNs(prefix = "srv", namespaceURI = "http://www.isotc211.org/2005/srv"), 
          @XmlNs(prefix = "gml", namespaceURI = "http://www.opengis.net/gml"), 
          @XmlNs(prefix = "xlink", namespaceURI = "http://www.w3.org/1999/xlink")
    }, 
    elementFormDefault = XmlNsForm.QUALIFIED)
package com.gaia3d.web.dto.wmo;

import javax.xml.bind.annotation.XmlNs;  
import javax.xml.bind.annotation.XmlSchema; 
import javax.xml.bind.annotation.XmlNsForm; 