package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.MasterDeviceDao;
import id.co.mandiri.entity.Device;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class MasterDeviceService implements ServiceCrudDataTablesPattern<Device, String> {

    @Autowired
    private MasterDeviceDao dao;

    @Override
    public Device findId(String s) {
        return dao.findId(s);
    }

    @Override
    public List<Device> findAll() {
        return null;
    }

    @Override
    @Transactional
    public Device save(Device value) {
        return dao.save(value);
    }

    @Override
    @Transactional
    public Device update(Device value) {
        return dao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(Device value) {
        return dao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return dao.removeById(s);
    }

    @Override
    public DataTablesResponse<Device> datatables(DataTablesRequest<Device> params) {
        List<Device> values = dao.datatables(params);
        Long rowCount = dao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
