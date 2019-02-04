package id.co.mandiri.dao;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.dao.DaoCrudDataTablesPattern;
import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.ColorDevice;
import id.co.mandiri.repository.CategoryDeviceRepository;
import id.co.mandiri.repository.ColorDeviceRepository;
import id.co.mandiri.utils.QueryComparator;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.awt.*;
import java.util.List;

@Repository
public class ColorDeviceDao implements DaoCrudDataTablesPattern<ColorDevice, String> {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    private ColorDeviceRepository colorDeviceRepository;

    @Override
    public ColorDevice findId(String s) {
        return colorDeviceRepository.findOne(s);
    }

    @Override
    @Deprecated
    public List<ColorDevice> findAll() {
        return null;
    }

    @Override
    public ColorDevice save(ColorDevice colorDevice) {
        return colorDeviceRepository.save(colorDevice);
    }

    @Override
    public ColorDevice update(ColorDevice colorDevice) {
        return colorDeviceRepository.save(colorDevice);
    }

    @Override
    public boolean remove(ColorDevice colorDevice) {
        colorDeviceRepository.delete(colorDevice);
        return true;
    }

    @Override
    public boolean removeById(String s) {
        colorDeviceRepository.delete(s);
        return true;
    }

    @Override
    public List<ColorDevice> datatables(DataTablesRequest<ColorDevice> params) {
        String baseQuery = "select id, name, description, color_code\n" +
                "from device_color\n" +
                "where 1 = 1 ";

        ColorDevice param = params.getValue();

        ColorDeviceQueryCompare compare = new ColorDeviceQueryCompare(baseQuery);
        StringBuilder query = compare.getQuery(param);
        MapSqlParameterSource values = compare.getParameters();

        switch (params.getColOrder().intValue()) {
            case 0:
                if (StringUtils.equalsIgnoreCase(params.getColDir(), "asc"))
                    query.append(" order by id asc ");
                else
                    query.append(" order by id desc ");
                break;
            case 1:
                if (StringUtils.equalsIgnoreCase(params.getColDir(), "asc"))
                    query.append(" order by name asc ");
                else
                    query.append(" order by name desc ");
                break;
            case 2:
                if (StringUtils.equalsIgnoreCase(params.getColDir(), "asc"))
                    query.append(" order by description asc ");
                else
                    query.append(" order by description desc ");
                break;
            default:
                if (StringUtils.equalsIgnoreCase(params.getColDir(), "asc"))
                    query.append(" order by id asc ");
                else
                    query.append(" order by id desc ");
                break;
        }

        query.append("limit :limit offset :offset");
        values.addValue("offset", params.getStart());
        values.addValue("limit", params.getLength());

        return this.jdbcTemplate.query(query.toString(), values, (resultSet, i) ->
                new ColorDevice(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        resultSet.getString("color_code")
                        ));
    }

    @Override
    public Long datatables(ColorDevice param) {
        String baseQuery = "select count(id) \n" +
                "from device_color\n" +
                "where 1 = 1 ";

        ColorDeviceQueryCompare compare = new ColorDeviceQueryCompare(baseQuery);
        StringBuilder query = compare.getQuery(param);
        MapSqlParameterSource values = compare.getParameters();

        return this.jdbcTemplate.queryForObject(
                query.toString(),
                values,
                (resultSet, i) -> resultSet.getLong(1)
        );

    }

    private class ColorDeviceQueryCompare implements QueryComparator<ColorDevice> {

        private MapSqlParameterSource parameterSource;
        private StringBuilder query;

        ColorDeviceQueryCompare(String query) {
            this.parameterSource = new MapSqlParameterSource();
            this.query = new StringBuilder(query);
        }


        @Override
        public StringBuilder getQuery(ColorDevice param) {
            if (StringUtils.isNoneBlank(param.getId())) {
                query.append(" and lower(id) like :id ");
                parameterSource.addValue("id",
                        new StringBuilder("%")
                                .append(param.getId().toLowerCase())
                                .append("%")
                                .toString());
            }

            if (StringUtils.isNoneBlank(param.getName())) {
                query.append(" and lower(name) like :name ");
                parameterSource.addValue("name", new StringBuilder("%")
                        .append(param.getName().toLowerCase())
                        .append("%")
                        .toString());
            }

            if (StringUtils.isNoneBlank(param.getDescription())) {
                query.append(" and lower(description) like :description ");
                parameterSource.addValue("description", new StringBuilder("%")
                        .append(param.getDescription().toLowerCase())
                        .append("%")
                        .toString());
            }
            return query;
        }

        @Override
        public MapSqlParameterSource getParameters() {
            return this.parameterSource;
        }
    }
}
