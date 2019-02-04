package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.ColorDeviceDao;
import id.co.mandiri.entity.ColorDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(readOnly = true)
public class ColorDeviceService implements ServiceCrudDataTablesPattern<ColorDevice, String> {

    @Autowired
    private ColorDeviceDao colorDao;

    @Override
    public ColorDevice findId(String s) {
        return colorDao.findId(s);
    }

    @Override
    public List<ColorDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public ColorDevice save(ColorDevice value) {
        return colorDao.save(value);
    }

    @Override
    @Transactional
    public ColorDevice update(ColorDevice value) {
        return colorDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(ColorDevice value) {
        return colorDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return colorDao.removeById(s);
    }

    @Override
    public DataTablesResponse<ColorDevice> datatables(DataTablesRequest<ColorDevice> params) {
        List<ColorDevice> values = colorDao.datatables(params);
        Long rowCount = colorDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
