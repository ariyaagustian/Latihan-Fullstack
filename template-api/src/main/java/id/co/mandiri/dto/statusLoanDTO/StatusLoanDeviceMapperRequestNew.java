package id.co.mandiri.dto.statusLoanDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StatusLoanDeviceMapperRequestNew extends ObjectMapper<StatusLoanDevice, StatusLoanDeviceDTO.StatusLoanDeviceRequestNewDTO> {

    StatusLoanDeviceMapperRequestNew converter = Mappers.getMapper(StatusLoanDeviceMapperRequestNew.class);

}
