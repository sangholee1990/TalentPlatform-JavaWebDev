package com.gaia3d.swfc.batch.util;

import java.util.Iterator;
import java.util.NoSuchElementException;

import org.joda.time.Days;
import org.joda.time.LocalDate;

public class LocalDateRange implements Iterable<LocalDate>
{
    private final LocalDate start;
    private final LocalDate end;

    public LocalDateRange(LocalDate start, LocalDate end)
    {
        this.start = start;
        this.end = end;
    }

    public Iterator<LocalDate> iterator()
    {
        return new LocalDateRangeIterator(start, end);
    }

    private static class LocalDateRangeIterator implements Iterator<LocalDate>
    {
        private LocalDate current;
        private final LocalDate end;

        private LocalDateRangeIterator(LocalDate start, LocalDate end)
        {
            this.current = start;
            this.end = end;
        }

        public boolean hasNext()
        {
            return current != null;
        }

        public LocalDate next()
        {
            if (current == null)
            {
                throw new NoSuchElementException();
            }
            LocalDate ret = current;
            current = current.plus(Days.ONE);
            if (current.compareTo(end) > 0)
            {
                current = null;
            }
            return ret;
        }

        public void remove()
        {
            throw new UnsupportedOperationException();
        }
    }
}