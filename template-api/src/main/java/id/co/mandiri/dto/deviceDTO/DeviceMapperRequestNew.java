package id.co.mandiri.dto.deviceDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.CategoryDevice;
import id.co.mandiri.entity.Device;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface DeviceMapperRequestNew extends ObjectMapper<Device, DeviceDTO.MasterDeviceRequestNewDTO> {

    DeviceMapperRequestNew converter = Mappers.getMapper(DeviceMapperRequestNew.class);

}
