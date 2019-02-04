package id.co.mandiri.dao;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.dao.DaoCrudDataTablesPattern;
import id.co.mandiri.entity.*;
import id.co.mandiri.repository.DeviceRepository;
import id.co.mandiri.utils.QueryComparator;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MasterDeviceDao implements DaoCrudDataTablesPattern<Device, String> {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    private DeviceRepository repository;

    @Override
    public Device findId(String s) {
        return repository.findOne(s);
    }

    @Override
    @Deprecated
    public List<Device> findAll() {
        return null;
    }

    @Override
    public Device save(Device masterDevice) {
        return repository.save(masterDevice);
    }

    @Override
    public Device update(Device masterDevice) {
        return repository.save(masterDevice);
    }

    @Override
    public boolean remove(Device masterDevice) {
        repository.delete(masterDevice);
        return true;
    }

    @Override
    public boolean removeById(String s) {
        repository.delete(s);
        return true;
    }

    @Override
    public List<Device> datatables(DataTablesRequest<Device> params) {
        String baseQuery = "select dev.id, dev.name, dev.description, \n" +
                "dev.category_id, dev.color_id, dev.merk_id, dev.condition_id, dev.unit_capacity_id, dev.status_loan_id,\n" +
                "cat.name as category, col.name as color, \n" +
                    "brand.name as brand, cond.name as `condition`, cap.name as unit_capacity, loan.name as loan_status\n" +
                "from device as dev\n" +
                "join device_category as cat on dev.category_id = cat.id\n" +
                "join device_color as col on dev.color_id = col.id\n" +
                "join device_merk as brand on dev.merk_id = brand.id\n" +
                "join device_condition as cond on dev.condition_id = cond.id\n" +
                "join device_unit_capacity as cap on dev.unit_capacity_id = cap.id\n" +
                "join device_loan_status as loan on dev.status_loan_id = loan.id\n" +
                "where 1=1 ";

        Device param = params.getValue();

        MasterDeviceQueryCompare compare = new MasterDeviceQueryCompare(baseQuery);
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
                    query.append(" order by code asc ");
                else
                    query.append(" order by code desc ");
                break;
            case 3:
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
                new Device(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description"),
                        new CategoryDevice(resultSet.getString("category_id"), resultSet.getString("category"), null),
                        new ColorDevice(resultSet.getString("color_id"), resultSet.getString("color"), null, null),
                        new MerkDevice(resultSet.getString("brand_id"), resultSet.getString("brand"), null, null),
                        new ConditionDevice(resultSet.getString("condition_id"), resultSet.getString("condition"), null, null),
                        new UnitCapacityDevice(resultSet.getString("unit_capacity_id"), resultSet.getString("unit_capacity"), null, null),
                        new StatusLoanDevice(resultSet.getString("loan_status_id"), resultSet.getString("loan_status"), null, null)
                ));
    }

    @Override
    public Long datatables(Device param) {
        String baseQuery = "select count(id) \n" +
                "from device \n" +
                "where 1 = 1 ";

        MasterDeviceDao.MasterDeviceQueryCompare compare = new MasterDeviceDao.MasterDeviceQueryCompare(baseQuery);
        StringBuilder query = compare.getQuery(param);
        MapSqlParameterSource values = compare.getParameters();

        return this.jdbcTemplate.queryForObject(
                query.toString(),
                values,
                (resultSet, i) -> resultSet.getLong(1)
        );

    }

    private class MasterDeviceQueryCompare implements QueryComparator<Device> {

        private MapSqlParameterSource parameterSource;
        private StringBuilder query;

        MasterDeviceQueryCompare(String query) {
            this.parameterSource = new MapSqlParameterSource();
            this.query = new StringBuilder(query);
        }


        @Override
        public StringBuilder getQuery(Device param) {
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
