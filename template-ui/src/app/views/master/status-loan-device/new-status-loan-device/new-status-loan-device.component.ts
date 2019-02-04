import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {FormBuilder, FormGroup} from '@angular/forms';
import {StatusLoanDeviceService} from '../status-loan-device.service';
  import {StatusLoanDevice} from '../../../../entity/status-loan-device.model';

@Component({
  selector: 'app-new-status-loan-device',
  templateUrl: './new-status-loan-device.component.html',
  styleUrls: ['./new-status-loan-device.component.scss']
})
export class NewStatusLoanDeviceComponent implements OnInit {

  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: StatusLoanDeviceService,
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

    const value: StatusLoanDevice = this.form.value;
    this._service.save(value).subscribe(resp => {
      this._toastr.info('New status-loan of Device Saved', 'Save Success');
      this._router.navigate(['master', 'status-loan-device']);
    }, error => {
      this._toastr.warning('There is something error', 'Oopss....');
    });
  }

  get f() {
    return this.form.controls;
  }
}
