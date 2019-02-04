package id.co.mandiri.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;

import javax.persistence.*;

@Entity
@Table(name = "device")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Device {

    @Id
    @GenericGenerator(name = "uuid_gen", strategy = "uuid2")
    @GeneratedValue(generator = "uuid_gen")
    @Column(name = "id", nullable = false, length = 64)
    private String id;

    @Column(name = "name", nullable = false, length = 150)
    private String name;
    @Lob
    @Type(type = "text")
    @Column(name = "description")
    private String description;

    @ManyToOne
    @JoinColumn(name = "category_id", nullable = false)
    private CategoryDevice category;

    @ManyToOne
    @JoinColumn(name = "color_id", nullable = false)
    private ColorDevice color;

    @ManyToOne
    @JoinColumn(name = "merk_id", nullable = false)
    private MerkDevice merk;

    @ManyToOne
    @JoinColumn(name = "condition_id", nullable = false)
    private ConditionDevice condition;

    @ManyToOne
    @JoinColumn(name = "unit_capacity_id", nullable = false)
    private UnitCapacityDevice unitCapacity;

    @ManyToOne
    @JoinColumn(name = "status_loan_id", nullable = false)
    private StatusLoanDevice loanStatus;
}
