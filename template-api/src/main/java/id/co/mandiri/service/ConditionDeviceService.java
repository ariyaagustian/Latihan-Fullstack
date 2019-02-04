package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.ConditionDeviceDao;
import id.co.mandiri.dao.MerkDeviceDao;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.MerkDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ConditionDeviceService implements ServiceCrudDataTablesPattern<ConditionDevice, String> {

    @Autowired
    private ConditionDeviceDao conditionDao;

    @Override
    public ConditionDevice findId(String s) {
        return conditionDao.findId(s);
    }

    @Override
    public List<ConditionDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public ConditionDevice save(ConditionDevice value) {
        return conditionDao.save(value);
    }

    @Override
    @Transactional
    public ConditionDevice update(ConditionDevice value) {
        return conditionDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(ConditionDevice value) {
        return conditionDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return conditionDao.removeById(s);
    }

    @Override
    public DataTablesResponse<ConditionDevice> datatables(DataTablesRequest<ConditionDevice> params) {
        List<ConditionDevice> values = conditionDao.datatables(params);
        Long rowCount = conditionDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
