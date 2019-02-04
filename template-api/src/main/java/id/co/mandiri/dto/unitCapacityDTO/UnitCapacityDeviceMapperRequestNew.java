package id.co.mandiri.dto.unitCapacityDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.StatusLoanDevice;
import id.co.mandiri.entity.UnitCapacityDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface UnitCapacityDeviceMapperRequestNew extends ObjectMapper<UnitCapacityDevice, UnitCapacityDeviceDTO.UnitCapacityDeviceRequestNewDTO> {

    UnitCapacityDeviceMapperRequestNew converter = Mappers.getMapper(UnitCapacityDeviceMapperRequestNew.class);

}
