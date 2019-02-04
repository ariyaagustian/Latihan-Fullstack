import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {FormBuilder, FormGroup} from '@angular/forms';
import {ColorDeviceService} from '../color-device.service';
import {ColorDevice} from '../../../../entity/color-device.model';

@Component({
  selector: 'app-new-color-device',
  templateUrl: './new-color-device.component.html',
  styleUrls: ['./new-color-device.component.scss']
})
export class NewColorDeviceComponent implements OnInit {

  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: ColorDeviceService,
    private _toastr: ToastrService,
    private _formBuilder: FormBuilder) {
  }


  ngOnInit(): void {
    this.form = new FormGroup({
      'name': this._formBuilder.control(''),
      'description': this._formBuilder.control(''),
      'color_code': this._formBuilder.control('')
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

    const value: ColorDevice = this.form.value;
    this._service.save(value).subscribe(resp => {
      this._toastr.info('New Category of Device Saved', 'Save Success');
      this._router.navigate(['master', 'color-device']);
    }, error => {
      this._toastr.warning('There is something error', 'Oopss....');
    });
  }

  get f() {
    return this.form.controls;
  }
}
