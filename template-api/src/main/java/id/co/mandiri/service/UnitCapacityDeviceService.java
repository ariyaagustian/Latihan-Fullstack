package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.StatusLoanDeviceDao;
import id.co.mandiri.dao.UnitCapacityDeviceDao;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.entity.UnitCapacityDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class UnitCapacityDeviceService implements ServiceCrudDataTablesPattern<UnitCapacityDevice, String> {

    @Autowired
    private UnitCapacityDeviceDao unitCapacityDao;

    @Override
    public UnitCapacityDevice findId(String s) {
        return unitCapacityDao.findId(s);
    }

    @Override
    public List<UnitCapacityDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public UnitCapacityDevice save(UnitCapacityDevice value) {
        return unitCapacityDao.save(value);
    }

    @Override
    @Transactional
    public UnitCapacityDevice update(UnitCapacityDevice value) {
        return unitCapacityDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(UnitCapacityDevice value) {
        return unitCapacityDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return unitCapacityDao.removeById(s);
    }

    @Override
    public DataTablesResponse<UnitCapacityDevice> datatables(DataTablesRequest<UnitCapacityDevice> params) {
        List<UnitCapacityDevice> values = unitCapacityDao.datatables(params);
        Long rowCount = unitCapacityDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
