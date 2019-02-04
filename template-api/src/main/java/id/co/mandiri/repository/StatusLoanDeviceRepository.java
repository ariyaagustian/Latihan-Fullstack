package id.co.mandiri.repository;

import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import org.springframework.data.repository.CrudRepository;

public interface StatusLoanDeviceRepository extends CrudRepository<StatusLoanDevice, String> {
}
