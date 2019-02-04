package id.co.mandiri.dto.categoryDTO;

import com.maryanto.dimas.plugins.web.commons.mappers.ObjectMapper;
import id.co.mandiri.entity.CategoryDevice;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface CategoryDeviceMapperRequestNew extends ObjectMapper<CategoryDevice, CategoryDeviceDTO.CategoriDeviceRequestNewDTO> {

    CategoryDeviceMapperRequestNew converter = Mappers.getMapper(CategoryDeviceMapperRequestNew.class);

}
