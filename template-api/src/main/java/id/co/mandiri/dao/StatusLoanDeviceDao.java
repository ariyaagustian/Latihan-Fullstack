package id.co.mandiri.dao;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.dao.DaoCrudDataTablesPattern;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.repository.ConditionDeviceRepository;
import id.co.mandiri.repository.StatusLoanDeviceRepository;
import id.co.mandiri.utils.QueryComparator;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class StatusLoanDeviceDao implements DaoCrudDataTablesPattern<StatusLoanDevice, String> {

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @Autowired
    private StatusLoanDeviceRepository statusLoanDeviceRepository;

    @Override
    public StatusLoanDevice findId(String s) {
        return statusLoanDeviceRepository.findOne(s);
    }

    @Override
    @Deprecated
    public List<StatusLoanDevice> findAll() {
        return null;
    }

    @Override
    public StatusLoanDevice save(StatusLoanDevice statusLoanDevice) {
        return statusLoanDeviceRepository.save(statusLoanDevice);
    }

    @Override
    public StatusLoanDevice update(StatusLoanDevice statusLoanDevice) {
        return statusLoanDeviceRepository.save(statusLoanDevice);
    }

    @Override
    public boolean remove(StatusLoanDevice statusLoanDevice) {
        statusLoanDeviceRepository.delete(statusLoanDevice);
        return true;
    }

    @Override
    public boolean removeById(String s) {
        statusLoanDeviceRepository.delete(s);
        return true;
    }

    @Override
    public List<StatusLoanDevice> datatables(DataTablesRequest<StatusLoanDevice> params) {
        String baseQuery = "select id, name, description\n" +
                "from device_loan_status \n" +
                "where 1 = 1 ";

        StatusLoanDevice param = params.getValue();

        StatusLoanDeviceQueryCompare compare = new StatusLoanDeviceQueryCompare(baseQuery);
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
                new StatusLoanDevice(
                        resultSet.getString("id"),
                        resultSet.getString("name"),
                        resultSet.getString("description")
                        ));
    }

    @Override
    public Long datatables(StatusLoanDevice param) {
        String baseQuery = "select count(id) \n" +
                "from device_condition\n" +
                "where 1 = 1 ";

        StatusLoanDeviceQueryCompare compare = new StatusLoanDeviceQueryCompare(baseQuery);
        StringBuilder query = compare.getQuery(param);
        MapSqlParameterSource values = compare.getParameters();

        return this.jdbcTemplate.queryForObject(
                query.toString(),
                values,
                (resultSet, i) -> resultSet.getLong(1)
        );

    }

    private class StatusLoanDeviceQueryCompare implements QueryComparator<StatusLoanDevice> {

        private MapSqlParameterSource parameterSource;
        private StringBuilder query;

        StatusLoanDeviceQueryCompare(String query) {
            this.parameterSource = new MapSqlParameterSource();
            this.query = new StringBuilder(query);
        }


        @Override
        public StringBuilder getQuery(StatusLoanDevice param) {
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
