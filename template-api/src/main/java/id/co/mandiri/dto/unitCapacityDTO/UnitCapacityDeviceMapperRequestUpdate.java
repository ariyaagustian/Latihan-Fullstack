package id.co.mandiri.dto.unitCapacityDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.entity.UnitCapacityDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UnitCapacityDeviceMapperRequestUpdate extends ObjectMapper<UnitCapacityDevice, UnitCapacityDeviceDTO.UnitCapacityDeviceRequestUpdateDTO> {

    UnitCapacityDeviceMapperRequestUpdate converter = Mappers.getMapper(UnitCapacityDeviceMapperRequestUpdate.class);
}
