import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {FormBuilder, FormGroup} from '@angular/forms';
import {UnitCapacityDeviceService} from '../unit-capacity-device.service';
import {UnitCapacityDevice} from '../../../../entity/unit-capacity-device.model';

@Component({
  selector: 'app-new-unit-capacity-device',
  templateUrl: './new-unit-capacity-device.component.html',
  styleUrls: ['./new-unit-capacity-device.component.scss']
})
export class NewUnitCapacityDeviceComponent implements OnInit {

  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: UnitCapacityDeviceService,
    private _toastr: ToastrService,
    private _formBuilder: FormBuilder) {
  }


  ngOnInit(): void {
    this.form = new FormGroup({
      'name': this._formBuilder.control(''),
      'description': this._formBuilder.control('')
    });
  }

  send(data): void {
    this.submitted = true;
    if (this.form.invalid) {
      this._toastr.warning('Field Not Allowed Empty', 'Can\'t Save Change Type',
        {
          timeOut: 5000
        });
      return;
    }

    const value: UnitCapacityDevice = this.form.value;
    this._service.save(value).subscribe(resp => {
      this._toastr.info('New unit-capacity of Device Saved', 'Save Success');
      this._router.navigate(['master', 'unit-capacity-device']);
    }, error => {
      this._toastr.warning('There is something error', 'Oopss....');
    });
  }

  get f() {
    return this.form.controls;
  }
}
