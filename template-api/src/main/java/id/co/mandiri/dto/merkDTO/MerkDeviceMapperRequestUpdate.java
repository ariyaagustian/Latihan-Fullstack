package id.co.mandiri.dto.merkDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.ColorDevice;
import id.co.mandiri.entity.MerkDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MerkDeviceMapperRequestUpdate extends ObjectMapper<MerkDevice, MerkDeviceDTO.MerkDeviceRequestUpdateDTO> {

    MerkDeviceMapperRequestUpdate converter = Mappers.getMapper(MerkDeviceMapperRequestUpdate.class);
}
