package id.co.mandiri.dto.colorDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.ColorDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface ColorDeviceMapperRequestUpdate extends ObjectMapper<ColorDevice, ColorDeviceDTO.ColorDeviceRequestUpdateDTO> {

    ColorDeviceMapperRequestUpdate converter = Mappers.getMapper(ColorDeviceMapperRequestUpdate.class);
}
