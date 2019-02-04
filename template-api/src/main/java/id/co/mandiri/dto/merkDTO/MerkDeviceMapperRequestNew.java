package id.co.mandiri.dto.merkDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.ColorDevice;
import id.co.mandiri.entity.MerkDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface MerkDeviceMapperRequestNew extends ObjectMapper<MerkDevice, MerkDeviceDTO.MerkDeviceRequestNewDTO> {

    MerkDeviceMapperRequestNew converter = Mappers.getMapper(MerkDeviceMapperRequestNew.class);

}
