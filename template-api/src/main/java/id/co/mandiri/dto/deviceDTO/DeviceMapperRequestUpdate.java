package id.co.mandiri.dto.deviceDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.Device;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface DeviceMapperRequestUpdate extends ObjectMapper<Device, DeviceDTO.MasterDeviceRequestUpdateDTO> {

    DeviceMapperRequestUpdate converter = Mappers.getMapper(DeviceMapperRequestUpdate.class);
}
