package id.co.mandiri.utils;

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;

public interface QueryComparator<T> {

    public StringBuilder getQuery(T params);

    public MapSqlParameterSource getParameters();
}
