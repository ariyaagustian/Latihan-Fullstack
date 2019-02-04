package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.ConditionDeviceDao;
import id.co.mandiri.dao.StatusLoanDeviceDao;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class StatusLoanDeviceService implements ServiceCrudDataTablesPattern<StatusLoanDevice, String> {

    @Autowired
    private StatusLoanDeviceDao statusLoanDao;

    @Override
    public StatusLoanDevice findId(String s) {
        return statusLoanDao.findId(s);
    }

    @Override
    public List<StatusLoanDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public StatusLoanDevice save(StatusLoanDevice value) {
        return statusLoanDao.save(value);
    }

    @Override
    @Transactional
    public StatusLoanDevice update(StatusLoanDevice value) {
        return statusLoanDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(StatusLoanDevice value) {
        return statusLoanDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return statusLoanDao.removeById(s);
    }

    @Override
    public DataTablesResponse<StatusLoanDevice> datatables(DataTablesRequest<StatusLoanDevice> params) {
        List<StatusLoanDevice> values = statusLoanDao.datatables(params);
        Long rowCount = statusLoanDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
