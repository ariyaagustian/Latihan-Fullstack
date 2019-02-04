import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {FormBuilder, FormGroup} from '@angular/forms';
import {MerkDeviceService} from '../merk-device.service';
import {MerkDevice} from '../../../../entity/merk-device.model';

@Component({
  selector: 'app-new-merk-device',
  templateUrl: './new-merk-device.component.html',
  styleUrls: ['./new-merk-device.component.scss']
})
export class NewMerkDeviceComponent implements OnInit {

  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: MerkDeviceService,
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

    const value: MerkDevice = this.form.value;
    this._service.save(value).subscribe(resp => {
      this._toastr.info('New merk of Device Saved', 'Save Success');
      this._router.navigate(['master', 'merk-device']);
    }, error => {
      this._toastr.warning('There is something error', 'Oopss....');
    });
  }

  get f() {
    return this.form.controls;
  }
}
