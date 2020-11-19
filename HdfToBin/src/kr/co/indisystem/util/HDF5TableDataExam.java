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

import java.awt.Color;
import java.awt.Component;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.StringReader;
import java.lang.reflect.Array;
import java.math.BigInteger;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.BitSet;
import java.util.Enumeration;
import java.util.List;
import java.util.StringTokenizer;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.CellEditor;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JTable;
import javax.swing.UIManager;
import javax.swing.border.Border;
import javax.swing.border.CompoundBorder;
import javax.swing.border.MatteBorder;
import javax.swing.border.TitledBorder;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ListSelectionEvent;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumn;

import ncsa.hdf.object.CompoundDS;
import ncsa.hdf.object.Dataset;
import ncsa.hdf.object.Datatype;
import ncsa.hdf.object.FileFormat;
import ncsa.hdf.object.HObject;
import ncsa.hdf.object.ScalarDS;
import ncsa.hdf.view.TableView;
import ncsa.hdf.view.Tools;
import ncsa.hdf.view.ViewProperties;

/**
 * TableView displays an HDF dataset as a two-dimensional table.
 * 
 * @author Peter X. Cao
 * @version 2.4 9/6/2007
 */
public class HDF5TableDataExam extends JInternalFrame implements TableView {
	private static final long serialVersionUID = HObject.serialVersionUID;

	/**
	 * Numerical data type. B = byte array, S = short array, I = int array, J =
	 * long array, F = float array, and D = double array.
	 */
	private char NT = ' ';

	/**
	 * The Scalar Dataset.
	 */
	private Dataset dataset;

	/**
	 * The value of the dataset.
	 */
	private Object dataValue;

	/**
	 * The table used to hold the table data.
	 */
	private JTable table;

	private boolean isValueChanged;

	private final Toolkit toolkit;

	private boolean isReadOnly;

	private boolean isDisplayTypeChar;

	private boolean isDataTransposed;

	private boolean isRegRef, isObjRef;

	private int fixedDataLength;

	private final NumberFormat normalFormat = null;// NumberFormat.getInstance();
	private NumberFormat numberFormat = normalFormat;
	private boolean showAsHex = false, showAsBin = false;
	private final boolean startEditing[] = { false };

	private BitSet bitmask;

	/*public static void main(String[] args) throws Exception {

		String filename = "mtsat1r_jami_hrit_zzz_f_200901020733.h5";
		H5File file = new H5File(filename, H5File.READ);
		HObject obj = file.get("/Image/Geostationary/DK01IR2");

		HDF5TableDataExam t = new HDF5TableDataExam(obj);
		t.printText();
	}*/

	/**
	 * Constructs an TableView.
	 * <p>
	 * 
	 * @param theView
	 *            the main HDFView.
	 * @param map
	 *            the properties on how to show the data. The map is used to
	 *            allow applications to pass properties on how to display the
	 *            data, such as, transposing data, showing data as character,
	 *            applying bitmask, and etc. Predefined keys are listed at
	 *            ViewProperties.DATA_VIEW_KEY.
	 */
	public HDF5TableDataExam(HObject obj) {
		// super();

		setDefaultCloseOperation(JInternalFrame.DISPOSE_ON_CLOSE);

		toolkit = Toolkit.getDefaultToolkit();
		isValueChanged = false;
		isReadOnly = false;
		isRegRef = false;
		isObjRef = false;
		fixedDataLength = -1;
		bitmask = null;

		dataset = (Dataset) obj;
		dataset.init();
		isReadOnly = dataset.getFileFormat().isReadOnly();

		long[] dims = dataset.getDims();
		long tsize = 1;

		for (int i = 0; i < dims.length; i++)
			tsize *= dims[i];

		if (dataset.getHeight() <= 0 || dataset.getWidth() <= 0 || tsize <= 0)
			return;

		// cannot edit hdf4 vdata
		if (dataset.getFileFormat().isThisType(
				FileFormat.getFileFormat(FileFormat.FILE_TYPE_HDF4))
				&& (dataset instanceof CompoundDS)) {
			isReadOnly = true;
		}

		// disable edit feature for szip compression when encode is not enabled
		if (!isReadOnly) {
			String compression = dataset.getCompression();
			if ((compression != null) && compression.startsWith("SZIP")) {
				if (!compression.endsWith("ENCODE_ENABLED")) {
					isReadOnly = true;
				}
			}
		}

		Datatype dtype = dataset.getDatatype();
		isDisplayTypeChar = (isDisplayTypeChar && (dtype.getDatatypeSize() == 1 || (dtype
				.getDatatypeClass() == Datatype.CLASS_ARRAY && dtype
				.getBasetype().getDatatypeClass() == Datatype.CLASS_CHAR)));

		dataset.setEnumConverted(ViewProperties.isConvertEnum());

		// create the table and its columnHeader
		if (dataset instanceof CompoundDS) {
			isDataTransposed = false; // disable transpose for compound dataset
			table = createTable((CompoundDS) dataset);
			/* if (dataset instanceof ScalarDS) */
		} else {
			table = createTable((ScalarDS) dataset);
			if (dtype.getDatatypeClass() == Datatype.CLASS_REFERENCE) {
				if (dtype.getDatatypeSize() > 8) {
					isReadOnly = true;
					isRegRef = true;
				} else
					isObjRef = true;
			}
		}

		if (table == null) {
			dataset = null;
			return;
		}		
	}

	// Implementing DataView.
	public HObject getDataObject() {
		return dataset;
	}

	// Implementing TableObserver.
	public JTable getTable() {
		return table;
	}

	/**
	 * Returns the selected data values.
	 */
	public Object getSelectedData() {
		if (dataset instanceof CompoundDS) {
			return getSelectedCompoundData();
		} else {
			return getSelectedScalarData();
		}
	}

	/**
	 * Returns the selected data values.
	 */
	private Object getSelectedScalarData() {
		Object selectedData = null;

		int[] selectedRows = table.getSelectedRows();
		int[] selectedCols = table.getSelectedColumns();
		if (selectedRows == null || selectedRows.length <= 0
				|| selectedCols == null || selectedCols.length <= 0) {
			return null;
		}

		int size = selectedCols.length * selectedRows.length;

		// the whole table is selected
		if ((table.getColumnCount() == selectedCols.length)
				&& (table.getRowCount() == selectedRows.length)) {
			return dataValue;
		}

		selectedData = null;
		if (isRegRef) {
			// reg. ref data are stored in strings
			selectedData = new String[size];
		} else {
			switch (NT) {
			case 'B':
				selectedData = new byte[size];
				break;
			case 'S':
				selectedData = new short[size];
				break;
			case 'I':
				selectedData = new int[size];
				break;
			case 'J':
				selectedData = new long[size];
				break;
			case 'F':
				selectedData = new float[size];
				break;
			case 'D':
				selectedData = new double[size];
				break;
			default:
				selectedData = null;
				break;
			}
		}

		if (selectedData == null) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, "Unsupported data type.",
					getTitle(), JOptionPane.ERROR_MESSAGE);
			return null;
		}

		int r0 = table.getSelectedRow();
		int c0 = table.getSelectedColumn();
		int w = table.getColumnCount();
		int idx_src = 0, idx_dst = 0;
		for (int i = 0; i < selectedRows.length; i++) {
			for (int j = 0; j < selectedCols.length; j++) {
				idx_src = selectedRows[i] * w + selectedCols[j];
				Array.set(selectedData, idx_dst, Array.get(dataValue, idx_src));
				idx_dst++;

			}
		}

		// this only works for continuous cells
		// for (int i=0; i<rows; i++)
		// {
		// idx_src = (r0+i)*w+c0;
		// System.arraycopy(dataValue, idx_src, selectedData, idx_dst, cols);
		// idx_dst += cols;
		// }

		return selectedData;
	}

	/**
	 * Returns the selected data values.
	 */
	private Object getSelectedCompoundData() {
		Object selectedData = null;

		int cols = table.getSelectedColumnCount();
		int rows = table.getSelectedRowCount();

		if ((cols <= 0) || (rows <= 0)) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, "No data is selected.",
					getTitle(), JOptionPane.ERROR_MESSAGE);
			return null;
		}

		Object colData = null;
		try {
			colData = ((List) dataset.getData()).get(table.getSelectedColumn());
		} catch (Exception ex) {
			return null;
		}

		int size = Array.getLength(colData);
		String cName = colData.getClass().getName();
		int cIndex = cName.lastIndexOf("[");
		char nt = ' ';
		if (cIndex >= 0) {
			nt = cName.charAt(cIndex + 1);
		}

		if (nt == 'B') {
			selectedData = new byte[size];
		} else if (nt == 'S') {
			selectedData = new short[size];
		} else if (nt == 'I') {
			selectedData = new int[size];
		} else if (nt == 'J') {
			selectedData = new long[size];
		} else if (nt == 'F') {
			selectedData = new float[size];
		} else if (nt == 'D') {
			selectedData = new double[size];
		} else {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, "Unsupported data type.",
					getTitle(), JOptionPane.ERROR_MESSAGE);
			return null;
		}

		System.arraycopy(colData, 0, selectedData, 0, size);

		return selectedData;
	}

	/**
	 * Creates a JTable to hold a scalar dataset.
	 */
	private JTable createTable(ScalarDS d) {
		JTable theTable = null;
		int rows = 0, cols = 0;

		int rank = d.getRank();
		if (rank <= 0) {
			d.init();
			rank = d.getRank();
		}
		long[] dims = d.getSelectedDims();

		rows = (int) dims[0];
		cols = 1;
		if (rank > 1) {
			rows = d.getHeight();
			cols = d.getWidth();
		}

		dataValue = null;
		try {
			dataValue = d.getData();

			if (Tools.applyBitmask(dataValue, bitmask)) {
				isReadOnly = true;
				Border border = BorderFactory.createCompoundBorder(
						BorderFactory.createRaisedBevelBorder(), BorderFactory
								.createTitledBorder(BorderFactory
										.createLineBorder(Color.BLUE, 3),
										"By bitmask " + bitmask,
										TitledBorder.RIGHT, TitledBorder.TOP,
										this.getFont(), Color.RED));
				this.setBorder(border);
			}

			d.convertFromUnsignedC();
			dataValue = d.getData();

			if (Array.getLength(dataValue) <= rows)
				cols = 1;
		} catch (Exception ex) {
			dataValue = null;
		}

		if (dataValue == null) {
			return null;
		}

		String cName = dataValue.getClass().getName();
		int cIndex = cName.lastIndexOf("[");
		if (cIndex >= 0) {
			NT = cName.charAt(cIndex + 1);
		}
		boolean isVL = cName.startsWith("[Ljava.lang.String;");

		// convert nubmerical data into char
		// only possible cases are byte[] and short[] (converted from unsigned
		// byte)
		if (isDisplayTypeChar && ((NT == 'B') || (NT == 'S'))) {
			int n = Array.getLength(dataValue);
			char[] charData = new char[n];
			for (int i = 0; i < n; i++) {
				if (NT == 'B') {
					charData[i] = (char) Array.getByte(dataValue, i);
				} else if (NT == 'S') {
					charData[i] = (char) Array.getShort(dataValue, i);
				}
			}

			dataValue = charData;
		} else if ((NT == 'B')
				&& dataset.getDatatype().getDatatypeClass() == Datatype.CLASS_ARRAY) {
			Datatype baseType = dataset.getDatatype().getBasetype();
			if (baseType.getDatatypeClass() == Datatype.CLASS_STRING) {
				dataValue = Dataset.byteToString((byte[]) dataValue, baseType
						.getDatatypeSize());
			}
		}

		final String columnNames[] = new String[cols];
		final int rowCount = rows;
		final int colCount = cols;
		final long[] startArray = dataset.getStartDims();
		final long[] strideArray = dataset.getStride();
		int[] selectedIndex = dataset.getSelectedIndex();
		final int rowStart = (int) startArray[selectedIndex[0]];
		final int rowStride = (int) strideArray[selectedIndex[0]];
		int start = 0;
		int stride = 1;

		if (rank > 1) {
			start = (int) startArray[selectedIndex[1]];
			stride = (int) strideArray[selectedIndex[1]];
		}

		for (int i = 0; i < cols; i++) {
			columnNames[i] = String.valueOf(start + i * stride);
		}

		AbstractTableModel tm = new AbstractTableModel() {
			private static final long serialVersionUID = HObject.serialVersionUID;
			private final StringBuffer stringBuffer = new StringBuffer();
			private final Datatype dtype = dataset.getDatatype();
			private final Datatype btype = dtype.getBasetype();
			private final int typeSize = dtype.getDatatypeSize();
			private final boolean isArray = (dtype.getDatatypeClass() == Datatype.CLASS_ARRAY);
			private final boolean isStr = (NT == 'L');
			private final boolean isInt = (NT == 'B' || NT == 'S' || NT == 'I' || NT == 'J');
			private final boolean isUINT64 = (dtype.isUnsigned() && (NT == 'J'));
			private Object theValue;

			public int getColumnCount() {
				return columnNames.length;
			}

			public int getRowCount() {
				return rowCount;
			}

			public String getColumnName(int col) {
				return columnNames[col];
			}

			public Object getValueAt(int row, int column) {
				if (startEditing[0])
					return "";

				if (isArray) {
					// ARRAY dataset
					int arraySize = dtype.getDatatypeSize()
							/ btype.getDatatypeSize();
					stringBuffer.setLength(0); // clear the old string
					int i0 = (row * colCount + column) * arraySize;
					int i1 = i0 + arraySize;

					if (isDisplayTypeChar) {
						for (int i = i0; i < i1; i++) {
							stringBuffer.append(Array.getChar(dataValue, i));
							if (stringBuffer.length() > 0 && i < (i1 - 1))
								stringBuffer.append(", ");
						}
					} else {
						for (int i = i0; i < i1; i++) {
							stringBuffer.append(Array.get(dataValue, i));
							if (stringBuffer.length() > 0 && i < (i1 - 1))
								stringBuffer.append(", ");
						}
					}
					theValue = stringBuffer;
				} else {
					if (isDataTransposed) {
						theValue = Array
								.get(dataValue, column * rowCount + row);
					} else {
						theValue = Array
								.get(dataValue, row * colCount + column);
					}

					if (isStr)
						return theValue;

					if (isUINT64) {
						Long l = (Long) theValue;
						if (l < 0) {
							l = (l << 1) >> 1;
							BigInteger big1 = new BigInteger(
									"9223372036854775808"); // 2^65
							BigInteger big2 = new BigInteger(l.toString());
							BigInteger big = big1.add(big2);
							theValue = big.toString();
						}
					} else if (showAsHex && isInt) {
						// show in Hexadecimal
						theValue = Long.toHexString(Long.valueOf(theValue
								.toString()));
					} else if (showAsBin && isInt) {
						theValue = Tools.toBinaryString(Long.valueOf(theValue
								.toString()), typeSize);
						// theValue =
						// Long.toBinaryString(Long.valueOf(theValue.toString()));
					} else if (numberFormat != null) {
						// show in scientific format
						theValue = numberFormat.format(theValue);
					}
				}

				return theValue;
			} // getValueAt(int row, int column)
		};

		theTable = new JTable(tm) {
			private static final long serialVersionUID = HObject.serialVersionUID;
			private final Datatype dtype = dataset.getDatatype();
			private final boolean isArray = (dtype.getDatatypeClass() == Datatype.CLASS_ARRAY);

			public boolean isCellEditable(int row, int col) {
				if (isReadOnly || isDisplayTypeChar || isArray || showAsBin
						|| showAsHex) {
					return false;
				} else {
					return true;
				}
			}

			public boolean editCellAt(int row, int column,
					java.util.EventObject e) {

				if (!isCellEditable(row, column)) {
					return super.editCellAt(row, column, e);
				}

				if (e instanceof KeyEvent) {
					KeyEvent ke = (KeyEvent) e;
					if (ke.getID() == KeyEvent.KEY_PRESSED)
						startEditing[0] = true;
				}

				return super.editCellAt(row, column, e);
			}

			public void editingStopped(ChangeEvent e) {
				int row = getEditingRow();
				int col = getEditingColumn();
				super.editingStopped(e);
				startEditing[0] = false;

				Object source = e.getSource();

				if (source instanceof CellEditor) {
					CellEditor editor = (CellEditor) source;
					String cellValue = (String) editor.getCellEditorValue();

					try {
						updateValueInMemory(cellValue, row, col);
					} catch (Exception ex) {
						toolkit.beep();						
					}
				} // if (source instanceof CellEditor)
			}

			public boolean isCellSelected(int row, int column) {
				if ((getSelectedRow() == row)
						&& (getSelectedColumn() == column)) {

					Object val = getValueAt(row, column);
					String strVal = null;

					if (isRegRef) {
						String reg = (String) val;
						String oidStr = reg.substring(reg.indexOf(':') + 1, reg
								.indexOf(' '));
						long oid[] = { -1 };

						// decode object ID
						try {
							oid[0] = Long.valueOf(oidStr);
							HObject obj = FileFormat.findObject(dataset
									.getFileFormat(), oid);
							strVal = obj.getFullName() + " "
									+ reg.substring(reg.indexOf("{"));
						} catch (Exception ex) {
							strVal = null;
						}
					} else if (isObjRef) {
						Long ref = (Long) val;
						long oid[] = { ref.longValue() };

						// decode object ID
						try {
							HObject obj = FileFormat.findObject(dataset
									.getFileFormat(), oid);
							strVal = obj.getFullName();
						} catch (Exception ex) {
							strVal = null;
						}
					}

					if (strVal == null)
						strVal = val.toString();
				}

				return super.isCellSelected(row, column);
			}
		};

		return theTable;
	}

	/**
	 * Creates a JTable to hold a compound dataset.
	 */
	private JTable createTable(CompoundDS d) {
		JTable theTable = null;

		int rank = d.getRank();
		if (rank <= 0) {
			d.init();
		}

		long[] startArray = d.getStartDims();
		long[] strideArray = d.getStride();
		int[] selectedIndex = d.getSelectedIndex();

		// use lazy convert for large number of strings
		if (d.getHeight() > 10000) {
			d.setConvertByteToString(false);
		}

		dataValue = null;
		try {
			dataValue = d.getData();
		} catch (Exception ex) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, ex, getTitle(),
					JOptionPane.ERROR_MESSAGE);
			dataValue = null;
		}

		if ((dataValue == null) || !(dataValue instanceof List)) {
			return null;
		}

		final int rows = d.getHeight();
		int cols = d.getSelectedMemberCount();
		String[] columnNames = new String[cols];

		int idx = 0;
		String[] columnNamesAll = d.getMemberNames();
		for (int i = 0; i < columnNamesAll.length; i++) {
			if (d.isMemberSelected(i)) {
				columnNames[idx] = columnNamesAll[i];
				columnNames[idx] = columnNames[idx].replaceAll(
						CompoundDS.separator, "->");
				idx++;
			}
		}

		String[] subColumnNames = columnNames;
		int columns = d.getWidth();
		if (columns > 1) {
			// multi-dimension compound dataset
			subColumnNames = new String[columns * columnNames.length];
			int halfIdx = columnNames.length / 2;
			for (int i = 0; i < columns; i++) {
				for (int j = 0; j < columnNames.length; j++) {
					// display column index only once, in the middle of the
					// compound fields
					if (j == halfIdx) {
						subColumnNames[i * columnNames.length + j] = (i + 1)
								+ "\n " + columnNames[j];
					} else {
						subColumnNames[i * columnNames.length + j] = " \n "
								+ columnNames[j];
					}
				}
			}
		}

		final String[] allColumnNames = subColumnNames;
		AbstractTableModel tm = new AbstractTableModel() {
			private static final long serialVersionUID = HObject.serialVersionUID;

			List list = (List) dataValue;
			CompoundDS compound = (CompoundDS) dataset;
			int orders[] = compound.getSelectedMemberOrders();
			Datatype types[] = compound.getSelectedMemberTypes();
			StringBuffer stringBuffer = new StringBuffer();
			int nFields = list.size();
			int nRows = getRowCount();
			int nSubColumns = (nFields > 0) ? getColumnCount() / nFields : 0;

			public int getColumnCount() {
				return allColumnNames.length;
			}

			public int getRowCount() {
				return rows;
			}

			public String getColumnName(int col) {
				return allColumnNames[col];
			}

			public Object getValueAt(int row, int col) {
				if (startEditing[0])
					return "";

				int fieldIdx = col;
				int rowIdx = row;

				if (nSubColumns > 1) // multi-dimension compound dataset
				{
					int colIdx = col / nFields;
					fieldIdx = col - colIdx * nFields;
					// BUG 573: rowIdx = row*orders[fieldIdx] +
					// colIdx*nRows*orders[fieldIdx];
					rowIdx = row * orders[fieldIdx] * nSubColumns + colIdx
							* orders[fieldIdx];
					;
				} else {
					rowIdx = row * orders[fieldIdx];
				}

				Object colValue = list.get(fieldIdx);
				if (colValue == null) {
					return "Null";
				}

				stringBuffer.setLength(0); // clear the old string
				int[] mdim = compound.getMemeberDims(fieldIdx);
				if (mdim == null) {
					// member is not an ARRAY datatype
					int strlen = types[fieldIdx].getDatatypeSize();
					boolean isString = (types[fieldIdx].getDatatypeClass() == Datatype.CLASS_STRING);

					if ((orders[fieldIdx] <= 1) && isString && (strlen > 0)
							&& !compound.getConvertByteToString()) {
						// original data is a char array
						String str = new String(((byte[]) colValue), rowIdx
								* strlen, strlen);
						int idx = str.indexOf('\0');
						if (idx > 0) {
							str = str.substring(0, idx);
						}
						stringBuffer.append(str.trim());
					} else {
						stringBuffer.append(Array.get(colValue, rowIdx));
					}

					for (int i = 1; i < orders[fieldIdx]; i++) {
						stringBuffer.append(", ");
						stringBuffer.append(Array.get(colValue, rowIdx + i));
					}
				} else {
					// member is an ARRAY datatype
					for (int i = 0; i < orders[fieldIdx]; i++) {
						stringBuffer.append(Array.get(colValue, rowIdx + i));
						stringBuffer.append(", ");
					}
				}

				return stringBuffer;
			}
		};

		theTable = new JTable(tm) {
			private static final long serialVersionUID = HObject.serialVersionUID;

			int lastSelectedRow = -1;
			int lastSelectedColumn = -1;

			public boolean isCellEditable(int row, int column) {
				return !isReadOnly;
			}

			public boolean editCellAt(int row, int column,
					java.util.EventObject e) {

				if (!isCellEditable(row, column)) {
					return super.editCellAt(row, column, e);
				}

				if (e instanceof KeyEvent) {
					KeyEvent ke = (KeyEvent) e;
					if (ke.getID() == KeyEvent.KEY_PRESSED)
						startEditing[0] = true;
				}

				return super.editCellAt(row, column, e);
			}

			public void editingStopped(ChangeEvent e) {
				int row = getEditingRow();
				int col = getEditingColumn();
				super.editingStopped(e);
				startEditing[0] = false;

				Object source = e.getSource();

				if (source instanceof CellEditor) {
					CellEditor editor = (CellEditor) source;
					String cellValue = (String) editor.getCellEditorValue();

					try {
						updateValueInMemory(cellValue, row, col);
					} catch (Exception ex) {
						toolkit.beep();
						JOptionPane.showMessageDialog(this, ex, getTitle(),
								JOptionPane.ERROR_MESSAGE);
					}
				} // if (source instanceof CellEditor)
			}

		};

		if (columns > 1) {
			// multi-dimension compound dataset
			MultiLineHeaderRenderer renderer = new MultiLineHeaderRenderer(
					columns, columnNames.length);
			Enumeration local_enum = theTable.getColumnModel().getColumns();
			while (local_enum.hasMoreElements()) {
				((TableColumn) local_enum.nextElement())
						.setHeaderRenderer(renderer);
			}
		}

		return theTable;
	} /* createTable */

	/** paste data from the system clipboard to the spreadsheet. */
	private void pasteData() {
		int pasteDataFlag = JOptionPane.showConfirmDialog(this,
				"Do you want to paste selected data ?", this.getTitle(),
				JOptionPane.YES_NO_OPTION);
		if (pasteDataFlag == JOptionPane.NO_OPTION) {
			return;
		}

		int cols = table.getColumnCount();
		int rows = table.getRowCount();
		int r0 = table.getSelectedRow();
		int c0 = table.getSelectedColumn();

		if (c0 < 0) {
			c0 = 0;
		}
		if (r0 < 0) {
			r0 = 0;
		}
		int r = r0;
		int c = c0;

		Clipboard cb = Toolkit.getDefaultToolkit().getSystemClipboard();
		Transferable content = cb.getContents(this);
		String line = "";
		try {
			String s = (String) content
					.getTransferData(DataFlavor.stringFlavor);

			StringTokenizer st = new StringTokenizer(s, "\n");
			// read line by line
			while (st.hasMoreTokens() && (r < rows)) {
				line = st.nextToken();

				if (fixedDataLength < 1) {
					// separate by delimiter
					StringTokenizer lt = new StringTokenizer(line, "\t");
					while (lt.hasMoreTokens() && (c < cols)) {
						try {
							updateValueInMemory(lt.nextToken(), r, c);
						} catch (Exception ex) {
							continue;
						}
						c++;
					}
					r = r + 1;
					c = c0;
				} else {
					// the data has fixed length
					int n = line.length();
					String theVal;
					for (int i = 0; i < n; i = i + fixedDataLength) {
						try {
							theVal = line.substring(i, i + fixedDataLength);
							updateValueInMemory(theVal, r, c);
						} catch (Exception ex) {
							continue;
						}
						c++;
					}
				}
			}
		} catch (Throwable ex) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, ex, getTitle(),
					JOptionPane.ERROR_MESSAGE);
		}

		table.updateUI();
	}

	/** Save data as text. */
	public void saveAsText() throws Exception {	
        int cols = table.getColumnCount();
        int rows = table.getRowCount();
        DataOutputStream dos = null;
        try{
        	dos = new DataOutputStream(new FileOutputStream("d://test_int_1.bin"));
        	for (int i=0; i<rows; i++){
        		//byte[] b = BCD.encode(String.valueOf(table.getValueAt(i, 0)));
        		dos.write(BCD.encode(String.valueOf(table.getValueAt(i, 0))));
        			//dos.writeInt(Integer.parseInt(String.valueOf(table.getValueAt(i, 0))));
        		for (int j=1; j<cols; j++){
        			dos.write(BCD.encode(String.valueOf(table.getValueAt(i, 0))));
        			//dos.writeInt(Integer.parseInt(String.valueOf(table.getValueAt(i, j))));
        		}
        	}
        } catch (Exception e) {
			throw e;
		}finally{
			try{ if(dos != null) dos.close(); }catch(IOException ie){}
		}
        /*
        for (int i=0; i<rows; i++)
        {
            out.print(table.getValueAt(i, 0));
            for (int j=1; j<cols; j++)
            {
                out.print(delimiter);
                out.print(table.getValueAt(i, j));
            }
            out.println();
        }

        out.flush();
        out.close();
        */
	}

	/** Save data as text. */
	public short[][] printText() throws Exception {
		String delName = ViewProperties.getDataDelimiter();
		String delimiter = "\t";

		// delimiter must include a tab to be consistent with copy/paste (
		if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_SPACE)) {
			delimiter = " " + delimiter;
		} else if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_COMMA)) {
			delimiter = "," + delimiter;
		} else if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_COLON)) {
			delimiter = ":" + delimiter;
		} else if (delName
				.equalsIgnoreCase(ViewProperties.DELIMITER_SEMI_COLON)) {
			delimiter = ";" + delimiter;
		}

		int cols = table.getColumnCount();
		int rows = table.getRowCount();
		List list = new ArrayList();
		short[][] array = new short[rows][cols];
		for (int i = 0; i < rows; i++) {
			array[i][0] = Short.parseShort(  table.getValueAt(i, 0).toString() );
			for (int j = 1; j < cols; j++) {
				array[i][j] = Short.parseShort( table.getValueAt(i, j).toString() );
				if(!list.contains(array[i][j])){
					list.add(array[i][j]);
				}
			}
		}
		/*System.out.println("데이터값::" + list.size());
		for(int i = 0; i < list.size(); i++){
			short v =  Short.parseShort( list.get(i).toString() );
			System.out.println(v);
		}*/
		return array;
	}
	
	/** Save data as text. */
	public List getTestData() throws Exception {
		String delName = ViewProperties.getDataDelimiter();
		String delimiter = ",";
		
		// delimiter must include a tab to be consistent with copy/paste (
		/*if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_SPACE)) {
			delimiter = " " + delimiter;
		} else if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_COMMA)) {
			delimiter = "," + delimiter;
		} else if (delName.equalsIgnoreCase(ViewProperties.DELIMITER_COLON)) {
			delimiter = ":" + delimiter;
		} else if (delName
				.equalsIgnoreCase(ViewProperties.DELIMITER_SEMI_COLON)) {
			delimiter = ";" + delimiter;
		}*/
		
		int cols = table.getColumnCount();
		int rows = table.getRowCount();
		List list = new ArrayList();
		for (int i = 0; i < 1024; i++) {			
			String s = "";
			s = String.valueOf(table.getValueAt(i, 0));
			for (int j = 1; j < 1024; j++) {
				s += String.valueOf( delimiter );
				s += String.valueOf( table.getValueAt(i, j) );
			}
			list.add(s);
		}
		
		return list;
	}

	/**
	 * update dataset value in file. The change will go to file.
	 */
	public void updateValueInFile() {
		if (isReadOnly || showAsBin || showAsHex) {
			return;
		}

		// if (!(dataset instanceof ScalarDS) || !isValueChanged)
		if (!isValueChanged) {
			return;
		}

		try {
			dataset.write();
		} catch (Exception ex) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, ex, getTitle(),
					JOptionPane.ERROR_MESSAGE);
			return;
		}

		isValueChanged = false;
	}

	/**
	 * Selects all rows, columns, and cells in the table.
	 */
	private void selectAll() throws Exception {
		table.selectAll();
	}

	/**
	 * update cell value in memory. It does not change the dataset value in
	 * file.
	 * 
	 * @param cellValue
	 *            the string value of input.
	 * @param row
	 *            the row of the editing cell.
	 * @param col
	 *            the column of the editing cell.
	 */
	private void updateValueInMemory(String cellValue, int row, int col)
			throws Exception {
		if (dataset instanceof ScalarDS) {
			updateScalarData(cellValue, row, col);
		} else if (dataset instanceof CompoundDS) {
			updateCompoundData(cellValue, row, col);
		}
	}

	/**
	 * update cell value in memory. It does not change the dataset value in
	 * file.
	 * 
	 * @param cellValue
	 *            the string value of input.
	 * @param row
	 *            the row of the editing cell.
	 * @param col
	 *            the column of the editing cell.
	 */
	private void updateScalarData(String cellValue, int row, int col)
			throws Exception {
		if (!(dataset instanceof ScalarDS) || (cellValue == null)
				|| ((cellValue = cellValue.trim()) == null) || showAsBin
				|| showAsHex) {
			return;
		}

		int i = 0;
		if (isDataTransposed) {
			i = col * table.getRowCount() + row;
		} else {
			i = row * table.getColumnCount() + col;
		}

		ScalarDS sds = (ScalarDS) dataset;
		boolean isUnsigned = sds.isUnsigned();

		// check data range for unsigned datatype
		if (isUnsigned) {
			long lvalue = -1;
			long maxValue = Long.MAX_VALUE;

			lvalue = Long.parseLong(cellValue);

			if (lvalue < 0) {
				throw new NumberFormatException(
						"Negative value for unsigned integer: " + lvalue);
			}

			if (NT == 'S') {
				maxValue = 255;
			} else if (NT == 'I') {
				maxValue = 65535;
			} else if (NT == 'J') {
				maxValue = 4294967295L;
			}

			if ((lvalue < 0) || (lvalue > maxValue)) {
				throw new NumberFormatException("Data value is out of range: "
						+ lvalue);
			}
		}

		switch (NT) {
		case 'B':
			byte bvalue = 0;
			bvalue = Byte.parseByte(cellValue);
			Array.setByte(dataValue, i, bvalue);
			break;
		case 'S':
			short svalue = 0;
			svalue = Short.parseShort(cellValue);
			Array.setShort(dataValue, i, svalue);
			break;
		case 'I':
			int ivalue = 0;
			ivalue = Integer.parseInt(cellValue);
			Array.setInt(dataValue, i, ivalue);
			break;
		case 'J':
			long lvalue = 0;
			lvalue = Long.parseLong(cellValue);
			Array.setLong(dataValue, i, lvalue);
			break;
		case 'F':
			float fvalue = 0;
			fvalue = Float.parseFloat(cellValue);
			Array.setFloat(dataValue, i, fvalue);
			break;
		case 'D':
			double dvalue = 0;
			dvalue = Double.parseDouble(cellValue);
			Array.setDouble(dataValue, i, dvalue);
			break;
		}

		isValueChanged = true;
	}

	private void updateCompoundData(String cellValue, int row, int col)
			throws Exception {
		if (!(dataset instanceof CompoundDS) || (cellValue == null)
				|| ((cellValue = cellValue.trim()) == null)) {
			return;
		}

		CompoundDS compDS = (CompoundDS) dataset;
		List cdata = (List) compDS.getData();
		int orders[] = compDS.getSelectedMemberOrders();
		Datatype types[] = compDS.getSelectedMemberTypes();
		int nFields = cdata.size();
		int nSubColumns = table.getColumnCount() / nFields;
		int nRows = table.getRowCount();
		int column = col;
		int offset = 0;
		int morder = 1;

		if (nSubColumns > 1) // multi-dimension compound dataset
		{
			int colIdx = col / nFields;
			column = col - colIdx * nFields;
			// //BUG 573: offset = row*orders[column] +
			// colIdx*nRows*orders[column];
			offset = row * orders[column] * nSubColumns + colIdx
					* orders[column];
		} else {
			offset = row * orders[column];
		}
		morder = orders[column];

		Object mdata = cdata.get(column);

		// strings
		if (Array.get(mdata, 0) instanceof String) {
			Array.set(mdata, offset, cellValue);
			isValueChanged = true;
			return;
		} else if (types[column].getDatatypeClass() == Datatype.CLASS_STRING) {
			// it is string but not converted, still byte array
			int strlen = types[column].getDatatypeSize();
			offset *= strlen;
			byte[] bytes = cellValue.getBytes();
			byte[] bData = (byte[]) mdata;
			int n = Math.min(strlen, bytes.length);
			System.arraycopy(bytes, 0, bData, offset, n);
			offset += n;
			n = strlen - bytes.length;
			// space padding
			for (int i = 0; i < n; i++) {
				bData[offset + i] = ' ';
			}
			isValueChanged = true;
			return;
		}

		// numveric data
		char mNT = ' ';
		String cName = mdata.getClass().getName();
		int cIndex = cName.lastIndexOf("[");
		if (cIndex >= 0) {
			mNT = cName.charAt(cIndex + 1);
		}

		StringTokenizer st = new StringTokenizer(cellValue, ",");
		if (st.countTokens() < morder) {
			toolkit.beep();
			JOptionPane.showMessageDialog(this, "Number of data point < "
					+ morder + ".", getTitle(), JOptionPane.ERROR_MESSAGE);
			return;
		}

		String token = "";
		isValueChanged = true;
		switch (mNT) {
		case 'B':
			byte bvalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				bvalue = Byte.parseByte(token);
				Array.setByte(mdata, offset + i, bvalue);
			}
			break;
		case 'S':
			short svalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				svalue = Short.parseShort(token);
				Array.setShort(mdata, offset + i, svalue);
			}
			break;
		case 'I':
			int ivalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				ivalue = Integer.parseInt(token);
				Array.setInt(mdata, offset + i, ivalue);
			}
			break;
		case 'J':
			long lvalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				lvalue = Long.parseLong(token);
				Array.setLong(mdata, offset + i, lvalue);
			}
			break;
		case 'F':
			float fvalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				fvalue = Float.parseFloat(token);
				Array.setFloat(mdata, offset + i, fvalue);
			}
			break;
		case 'D':
			double dvalue = 0;
			for (int i = 0; i < morder; i++) {
				token = st.nextToken().trim();
				dvalue = Double.parseDouble(token);
				Array.setDouble(mdata, offset + i, dvalue);
			}
			break;
		default:
			isValueChanged = false;
		}
	}

	private class ColumnHeader extends JTableHeader {
		private static final long serialVersionUID = HObject.serialVersionUID;

		private int currentColumnIndex = -1;
		private int lastColumnIndex = -1;
		private JTable parentTable;

		public ColumnHeader(JTable theTable) {
			super(theTable.getColumnModel());

			parentTable = theTable;
			setReorderingAllowed(false);
		}

		protected void processMouseMotionEvent(MouseEvent e) {
			super.processMouseMotionEvent(e);

			if (e.getID() == MouseEvent.MOUSE_DRAGGED) {
				// do not do anything, just resize the column
				if (getResizingColumn() != null)
					return;

				int colEnd = columnAtPoint(e.getPoint());

				if (colEnd < 0) {
					colEnd = 0;
				}
				if (currentColumnIndex < 0) {
					currentColumnIndex = 0;
				}

				parentTable.clearSelection();

				if (colEnd > currentColumnIndex) {
					parentTable.setColumnSelectionInterval(currentColumnIndex,
							colEnd);
				} else {
					parentTable.setColumnSelectionInterval(colEnd,
							currentColumnIndex);
				}

				parentTable.setRowSelectionInterval(0, parentTable
						.getRowCount() - 1);
			}
		}

		protected void processMouseEvent(MouseEvent e) {
			super.processMouseEvent(e);

			int mouseID = e.getID();

			if (mouseID == MouseEvent.MOUSE_CLICKED) {
				if (currentColumnIndex < 0) {
					return;
				}

				if (e.isControlDown()) {
					// select discontinuous columns
					parentTable.addColumnSelectionInterval(currentColumnIndex,
							currentColumnIndex);
				} else if (e.isShiftDown()) {
					// select continuous columns
					if (lastColumnIndex < 0) {
						parentTable.addColumnSelectionInterval(0,
								currentColumnIndex);
					} else if (lastColumnIndex < currentColumnIndex) {
						parentTable.addColumnSelectionInterval(lastColumnIndex,
								currentColumnIndex);
					} else {
						parentTable.addColumnSelectionInterval(
								currentColumnIndex, lastColumnIndex);
					}
				} else {
					// clear old selection and set new column selection
					parentTable.clearSelection();
					parentTable.setColumnSelectionInterval(currentColumnIndex,
							currentColumnIndex);
				}

				lastColumnIndex = currentColumnIndex;
				parentTable.setRowSelectionInterval(0, parentTable
						.getRowCount() - 1);
			} else if (mouseID == MouseEvent.MOUSE_PRESSED) {
				currentColumnIndex = columnAtPoint(e.getPoint());
			}
		}
	} // private class ColumnHeader

	/** RowHeader defines the row header component of the Spreadsheet. */
	private class RowHeader extends JTable {
		private static final long serialVersionUID = HObject.serialVersionUID;

		private int currentRowIndex = -1;
		private int lastRowIndex = -1;
		private JTable parentTable;

		public RowHeader(JTable pTable, Dataset dset) {
			// Create a JTable with the same number of rows as
			// the parent table and one column.
			// super( pTable.getRowCount(), 1 );

			final long[] startArray = dset.getStartDims();
			final long[] strideArray = dset.getStride();
			final int[] selectedIndex = dset.getSelectedIndex();
			final int start = (int) startArray[selectedIndex[0]];
			final int stride = (int) strideArray[selectedIndex[0]];
			final int rowCount = pTable.getRowCount();
			parentTable = pTable;

			AbstractTableModel tm = new AbstractTableModel() {
				public int getColumnCount() {
					return 1;
				}

				public int getRowCount() {
					return rowCount;
				}

				public String getColumnName(int col) {
					return " ";
				}

				public Object getValueAt(int row, int column) {
					return String.valueOf(start + row * stride);
				}
			};

			this.setModel(tm);

			// Get the only table column.
			TableColumn col = getColumnModel().getColumn(0);

			// Use the cell renderer in the column.
			col.setCellRenderer(new RowHeaderRenderer());
		}

		/** Overridden to return false since the headers are not editable. */
		public boolean isCellEditable(int row, int col) {
			return false;
		}

		/** This is called when the selection changes in the row headers. */
		public void valueChanged(ListSelectionEvent e) {
			if (parentTable == null) {
				return;
			}

			int rows[] = getSelectedRows();
			if ((rows == null) || (rows.length == 0)) {
				return;
			}

			parentTable.clearSelection();
			parentTable.setRowSelectionInterval(rows[0], rows[rows.length - 1]);
			parentTable.setColumnSelectionInterval(0, parentTable
					.getColumnCount() - 1);
		}

		protected void processMouseMotionEvent(MouseEvent e) {
			if (e.getID() == MouseEvent.MOUSE_DRAGGED) {
				int colEnd = rowAtPoint(e.getPoint());

				if (colEnd < 0) {
					colEnd = 0;
				}
				if (currentRowIndex < 0) {
					currentRowIndex = 0;
				}

				parentTable.clearSelection();

				if (colEnd > currentRowIndex) {
					parentTable
							.setRowSelectionInterval(currentRowIndex, colEnd);
				} else {
					parentTable
							.setRowSelectionInterval(colEnd, currentRowIndex);
				}

				parentTable.setColumnSelectionInterval(0, parentTable
						.getColumnCount() - 1);
			}
		}

		protected void processMouseEvent(MouseEvent e) {
			int mouseID = e.getID();

			if (mouseID == MouseEvent.MOUSE_CLICKED) {
				if (currentRowIndex < 0) {
					return;
				}

				if (e.isControlDown()) {
					// select discontinguous rows
					parentTable.addRowSelectionInterval(currentRowIndex,
							currentRowIndex);
				} else if (e.isShiftDown()) {
					// select continguous columns
					if (lastRowIndex < 0) {
						parentTable.addRowSelectionInterval(0, currentRowIndex);
					} else if (lastRowIndex < currentRowIndex) {
						parentTable.addRowSelectionInterval(lastRowIndex,
								currentRowIndex);
					} else {
						parentTable.addRowSelectionInterval(currentRowIndex,
								lastRowIndex);
					}
				} else {
					// clear old selection and set new column selection
					parentTable.clearSelection();
					parentTable.setRowSelectionInterval(currentRowIndex,
							currentRowIndex);
				}

				lastRowIndex = currentRowIndex;

				parentTable.setColumnSelectionInterval(0, parentTable
						.getColumnCount() - 1);
			} else if (mouseID == MouseEvent.MOUSE_PRESSED) {
				currentRowIndex = rowAtPoint(e.getPoint());
			}
		}
	} // private class RowHeader extends JTable

	/**
	 * RowHeaderRenderer is a custom cell renderer that displays cells as
	 * buttons.
	 */
	private class RowHeaderRenderer extends JLabel implements TableCellRenderer {
		private static final long serialVersionUID = HObject.serialVersionUID;

		public RowHeaderRenderer() {
			super();
			setHorizontalAlignment(JLabel.CENTER);

			setOpaque(true);
			setBorder(UIManager.getBorder("TableHeader.cellBorder"));
			setBackground(Color.lightGray);
		}

		/** Configures the button for the current cell, and returns it. */
		public Component getTableCellRendererComponent(JTable table,
				Object value, boolean isSelected, boolean hasFocus, int row,
				int column) {
			setFont(table.getFont());

			if (value != null) {
				setText(value.toString());
			}

			return this;
		}
	} // private class RowHeaderRenderer extends JLabel implements
		// TableCellRenderer

	private class MultiLineHeaderRenderer extends JList implements
			TableCellRenderer {
		private static final long serialVersionUID = HObject.serialVersionUID;

		private final CompoundBorder subBorder = new CompoundBorder(
				new MatteBorder(1, 0, 1, 0, java.awt.Color.darkGray),
				new MatteBorder(1, 0, 1, 0, java.awt.Color.white));
		private final CompoundBorder majorBorder = new CompoundBorder(
				new MatteBorder(1, 1, 1, 0, java.awt.Color.darkGray),
				new MatteBorder(1, 2, 1, 0, java.awt.Color.white));
		Vector lines = new Vector();
		int nMajorcolumns = 1;
		int nSubcolumns = 1;

		public MultiLineHeaderRenderer(int majorColumns, int subColumns) {
			nMajorcolumns = majorColumns;
			nSubcolumns = subColumns;
			setOpaque(true);
			setForeground(UIManager.getColor("TableHeader.foreground"));
			setBackground(UIManager.getColor("TableHeader.background"));
		}

		public Component getTableCellRendererComponent(JTable table,
				Object value, boolean isSelected, boolean hasFocus, int row,
				int column) {
			setFont(table.getFont());
			String str = (value == null) ? "" : value.toString();
			BufferedReader br = new BufferedReader(new StringReader(str));
			String line;

			lines.clear();
			try {
				while ((line = br.readLine()) != null) {
					lines.addElement(line);
				}
			} catch (IOException ex) {
			}

			if ((column / nSubcolumns) * nSubcolumns == column) {
				setBorder(majorBorder);
			} else {
				setBorder(subBorder);
			}
			setListData(lines);

			return this;
		}
	}
}
