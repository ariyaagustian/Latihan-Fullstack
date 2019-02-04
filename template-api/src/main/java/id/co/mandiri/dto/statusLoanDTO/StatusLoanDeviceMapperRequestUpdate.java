package id.co.mandiri.dto.statusLoanDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.ConditionDevice;
import id.co.mandiri.entity.StatusLoanDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface StatusLoanDeviceMapperRequestUpdate extends ObjectMapper<StatusLoanDevice, StatusLoanDeviceDTO.StatusLoanDeviceRequestUpdateDTO> {

    StatusLoanDeviceMapperRequestUpdate converter = Mappers.getMapper(StatusLoanDeviceMapperRequestUpdate.class);
}
