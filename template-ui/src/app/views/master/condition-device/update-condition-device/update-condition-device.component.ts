import {Component, OnDestroy, OnInit} from '@angular/core';
import {ActivatedRoute, Params, Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {ConditionDeviceService} from '../condition-device.service';
import {Subscription} from 'rxjs';
import {FormBuilder, FormGroup, Validators} from '@angular/forms';
import {ConditionDevice} from '../../../../entity/condition-device.model';

@Component({
  selector: 'app-update-condition-device',
  templateUrl: './update-condition-device.component.html',
  styleUrls: ['./update-condition-device.component.scss']
})
export class UpdateConditionDeviceComponent implements OnInit, OnDestroy {

  private subcribeTopic: Subscription;
  form: FormGroup;
  submitted = false;

  constructor(
    private _router: Router,
    private _service: ConditionDeviceService,
    private _activeRoute: ActivatedRoute,
    private _toastr: ToastrService,
    private _formBuilder: FormBuilder) {
  }

  ngOnInit() {
    this.form = new FormGroup({
      id: this._formBuilder.control('', Validators.required),
      name: this._formBuilder.control('', Validators.required),
      description: this._formBuilder.control('')
    });

    this.subcribeTopic = this._activeRoute.params.subscribe((params: Params) => {
      const id = params['id'];
      this._service.getChangeTypes(id).subscribe((response: any) => {
        if (response.status === 204) {
          this._router.navigate(['master', 'condition-device']);
        } else {
          const value: ConditionDevice = response.body;
          console.log(value);
          this.form.setValue({
              'id': value.id,
              'name': value.name,
              'description': value.description
            }
          );
        }
      });
    });
  }

  send(data): void {
    this.submitted = true;
    if (this.form.invalid) {
      this._toastr.warning('Field Not Allowed Empty', 'Can\'t Update Change Type',
        {
          timeOut: 5000
        });
      return;
    }
    const value: ConditionDevice = this.form.value;
    this._service.update(value).subscribe(resp => {
      this._toastr.info('Change a v of device', 'Update Success');
      this._router.navigate(['master', 'condition-device']);
    }, error => {
      this._toastr.warning('Cant Update a condition of device', 'Oppss...');
      console.error('Can\'t be saved');
    });
  }

  get f() {
    return this.form.controls;
  }

  ngOnDestroy(): void {
    this.subcribeTopic.unsubscribe();
  }

}
