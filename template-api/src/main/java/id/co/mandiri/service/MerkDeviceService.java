package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.ColorDeviceDao;
import id.co.mandiri.dao.MerkDeviceDao;
import id.co.mandiri.entity.ColorDevice;
import id.co.mandiri.entity.MerkDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class MerkDeviceService implements ServiceCrudDataTablesPattern<MerkDevice, String> {

    @Autowired
    private MerkDeviceDao merkDao;

    @Override
    public MerkDevice findId(String s) {
        return merkDao.findId(s);
    }

    @Override
    public List<MerkDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public MerkDevice save(MerkDevice value) {
        return merkDao.save(value);
    }

    @Override
    @Transactional
    public MerkDevice update(MerkDevice value) {
        return merkDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(MerkDevice value) {
        return merkDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return merkDao.removeById(s);
    }

    @Override
    public DataTablesResponse<MerkDevice> datatables(DataTablesRequest<MerkDevice> params) {
        List<MerkDevice> values = merkDao.datatables(params);
        Long rowCount = merkDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
