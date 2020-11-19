package com.gaia3d.swfc.batch.util;

import static com.google.common.base.Preconditions.checkArgument;
import static com.google.common.base.Preconditions.checkNotNull;

import java.io.IOException;
import java.util.AbstractList;
import java.util.Arrays;
import java.util.Iterator;

import javax.annotation.Nullable;

public class BetterAppendable<A extends Appendable> extends AppendableDecorator implements Appendable {

	private final A wrappedAppendable;

	public BetterAppendable(A wrappedAppendable, @Nullable CharSequence nullText, @Nullable CharSequence newLine, @Nullable CharSequence separator, boolean skipNull, @Nullable CharSequence prefix, @Nullable CharSequence suffix) {
		super(nullText, newLine, separator, skipNull, prefix, suffix);
		this.wrappedAppendable = checkNotNull(wrappedAppendable);
	}

	public BetterAppendable(A wrappedAppendable, CharSequence nullText) {
		this(wrappedAppendable, nullText, null, null, false, null, null);
	}

	public BetterAppendable(A wrappedAppendable) {
		this(wrappedAppendable, null);
	}

	public BetterAppendable(BetterAppendable<A> p) {
		this(p.wrappedAppendable, p.nullText, p.newLine, p.separator, p.skipNull, p.prefix, p.suffix);
	}

	// If your using eclipse a nice diagonal black pattern of the parameter
	// being replaced should be visible.
	public BetterAppendable<A> nullText(CharSequence nullText) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public BetterAppendable<A> newLine(CharSequence newLine) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public BetterAppendable<A> separator(CharSequence separator) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public BetterAppendable<A> skipNull(boolean skipNull) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public BetterAppendable<A> prefix(CharSequence prefix) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	public BetterAppendable<A> suffix(CharSequence suffix) {
		return new BetterAppendable<A>(wrappedAppendable, nullText, newLine, separator, skipNull, prefix, suffix);
	}

	@Override
	public BetterAppendable<A> append(CharSequence cs) {
		try {
			return rewrap(wrappedAppendable.append(cs));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public BetterAppendable<A> append(char c) {
		try {
			return rewrap(wrappedAppendable.append(c));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public BetterAppendable<A> append(CharSequence cs, int start, int end) {
		try {
			return rewrap(wrappedAppendable.append(cs, start, end));
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	public BetterAppendable<A> append(Object obj) {
		if (obj == null) {
			return appendNull();
		}
		return append(obj.toString());
	}

	public BetterAppendable<A> appendParts(Iterator<?> parts) {
		BetterAppendable<A> a = this;
		// Lets decide if we are skipping nulls or not
		if (!skipNull) {
			if (parts.hasNext()) {
				if (prefix != null)
					a = a.append(prefix);
				a = a.append(objectToString(parts.next()));
				if (suffix != null)
					a = a.append(suffix);
				while (parts.hasNext()) {
					a = a.append(separator);
					if (prefix != null)
						a = a.append(prefix);
					a = a.append(objectToString(parts.next()));
					if (suffix != null)
						a = a.append(suffix);
				}
			}
		} else {
			while (parts.hasNext()) {
				Object part = parts.next();
				if (part != null) {
					if (prefix != null)
						a = a.append(prefix);
					a = a.append(objectToString(part));
					if (suffix != null)
						a = a.append(suffix);
					break;
				}
			}
			while (parts.hasNext()) {
				Object part = parts.next();
				if (part != null) {
					a = a.append(separator);
					if (prefix != null)
						a = a.append(prefix);
					a = a.append(objectToString(part));
					if (suffix != null)
						a = a.append(suffix);
				}
			}
		}
		return a;
	}

	public final BetterAppendable<A> appendParts(Object[] parts) {
		return appendParts(Arrays.asList(parts));
	}

	public final BetterAppendable<A> appendParts(@Nullable Object first, @Nullable Object second, Object... rest) {
		return appendParts(iterable(first, second, rest));
	}

	public BetterAppendable<A> appendParts(Iterable<?> parts) {
		return appendParts(parts.iterator());
	}

	public BetterAppendable<A> appendNull() {
		if (nullText == null) {
			return this;
		}
		return append(nullText);
	}

	public BetterAppendable<A> appendLine() {
		if (newLine == null) {
			return this;
		}
		return append(newLine);
	}

	public BetterAppendable<A> padStart(CharSequence string, int minLength, char padChar) {
		checkNotNull(string); // eager for GWT.
		if (string.length() >= minLength) {
			return this;
		}
		BetterAppendable<A> a = this;
		for (int i = string.length(); i < minLength; i++) {
			a = a.append(padChar);
		}
		a = a.append(string);
		return a;
	}

	public BetterAppendable<A> padEnd(CharSequence string, int minLength, char padChar) {
		checkNotNull(string); // eager for GWT.
		if (string.length() >= minLength) {
			return this;
		}
		BetterAppendable<A> a = this;
		a = a.append(string);
		for (int i = string.length(); i < minLength; i++) {
			a = a.append(padChar);
		}
		return a;
	}

	public BetterAppendable<A> repeat(Object string, long count) {
		if (count <= 1) {
			checkArgument(count >= 0, "invalid count: %s", count);
			return (count == 0) ? this.append("") : this;
		}
		BetterAppendable<A> a = this;
		for (long i = 0; i < count; count++) {
			a = a.append(objectToString(string));
		}
		return a;
	}

	@SuppressWarnings("unchecked")
	private BetterAppendable<A> rewrap(Appendable a) {
		if (a != wrappedAppendable) {
			// Oh you naughty bastard this is going to hurt.
			return wrap((A) a);
		}
		return this;
	}

	public A getAppendable() {
		return wrappedAppendable;
	}

	public String toString() {
		return wrappedAppendable.toString();
	}

	CharSequence objectToString(Object part) {
		if (part == null) {
			return checkNotNull(nullText, "null passed nullText not set"); // checkNotNull
																			// for
																			// GWT
																			// (do
																			// not
																			// optimize).
		} else {
			return (part instanceof CharSequence) ? (CharSequence) part : part.toString();
		}
	}

	private static Iterable<Object> iterable(final Object first, final Object second, final Object[] rest) {
		checkNotNull(rest);
		return new AbstractList<Object>() {

			@Override
			public int size() {
				return rest.length + 2;
			}

			@Override
			public Object get(int index) {
				switch (index) {
				case 0:
					return first;
				case 1:
					return second;
				default:
					return rest[index - 2];
				}
			}
		};
	}
}