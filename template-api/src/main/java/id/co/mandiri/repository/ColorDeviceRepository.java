package id.co.mandiri.repository;

import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.ColorDevice;
import org.springframework.data.repository.CrudRepository;

public interface ColorDeviceRepository extends CrudRepository<ColorDevice, String> {
}
