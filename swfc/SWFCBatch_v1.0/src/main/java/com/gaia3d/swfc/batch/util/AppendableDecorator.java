package com.gaia3d.swfc.batch.util;

import javax.annotation.Nullable;

public class AppendableDecorator {

	protected final CharSequence nullText;
	protected final CharSequence newLine;
	protected final boolean skipNull;
	protected final CharSequence prefix;
	protected final CharSequence suffix;
	protected final CharSequence separator;

	protected AppendableDecorator(@Nullable CharSequence nullText, @Nullable CharSequence newLine, @Nullable CharSequence separator, boolean skipNull, @Nullable CharSequence prefix, @Nullable CharSequence suffix) {
		super();
		this.nullText = nullText;
		if (newLine == null)
			this.newLine = getSystemProperty("line.separator");
		else
			this.newLine = newLine;
		this.prefix = prefix == null ? "" : prefix;
		this.suffix = suffix == null ? "" : suffix;
		this.separator = separator == null ? "" : separator;
		this.skipNull = skipNull;
	}

	private AppendableDecorator() {
		this(null, null, null, false, null, null);
	}

	public static AppendableDecorator builder() {
		return new AppendableDecorator();
	}

	private static AppendableDecorator defaultDecorator = new AppendableDecorator();

	public static <O extends Appendable> BetterAppendable<O> decorate(O wrappedAppendable) {
		return defaultDecorator.wrap(wrappedAppendable);
	}

	// If your using eclipse a nice diagonal black pattern of the parameter
	// being replaced should be visible.
	public <O extends Appendable> BetterAppendable<O> wrap(O wrappedAppendable) {
		return new BetterAppendable<O>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator nullText(CharSequence nullText) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator newLine(CharSequence newLine) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator separator(CharSequence separator) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator skipNull(boolean skipNull) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator prefix(CharSequence prefix) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public AppendableDecorator suffix(CharSequence suffix) {
		return new AppendableDecorator(nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public final String join(Object[] o) {
		return wrap(new StringBuilder()).appendParts(o).toString();
	}

	protected static String getSystemProperty(String property) {
		try {
			return System.getProperty(property);
		} catch (SecurityException ex) {
			// we are not allowed to look at this property
			System.err.println("Caught a SecurityException reading the system property '" + property + "'; the SystemUtils property value will default to null.");
			return null;
		}
	}
}