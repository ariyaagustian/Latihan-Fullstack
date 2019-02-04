package id.co.mandiri.service;

import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesRequest;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.DataTablesResponse;
import com.maryanto.dimas.plugins.web.commons.ui.datatables.service.ServiceCrudDataTablesPattern;
import id.co.mandiri.dao.CategoryDeviceDao;
import id.co.mandiri.entity.CategoryDevice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class CategoryDeviceService implements ServiceCrudDataTablesPattern<CategoryDevice, String> {

    @Autowired
    private CategoryDeviceDao categoryDao;

    @Override
    public CategoryDevice findId(String s) {
        return categoryDao.findId(s);
    }

    @Override
    public List<CategoryDevice> findAll() {
        return null;
    }

    @Override
    @Transactional
    public CategoryDevice save(CategoryDevice value) {
        return categoryDao.save(value);
    }

    @Override
    @Transactional
    public CategoryDevice update(CategoryDevice value) {
        return categoryDao.update(value);
    }

    @Override
    @Transactional
    public boolean remove(CategoryDevice value) {
        return categoryDao.remove(value);
    }

    @Override
    @Transactional
    public boolean removeById(String s) {
        return categoryDao.removeById(s);
    }

    @Override
    public DataTablesResponse<CategoryDevice> datatables(DataTablesRequest<CategoryDevice> params) {
        List<CategoryDevice> values = categoryDao.datatables(params);
        Long rowCount = categoryDao.datatables(params.getValue());
        return new DataTablesResponse<>(values, params.getDraw(), rowCount, rowCount);
    }
}
