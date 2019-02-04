import {ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot} from '@angular/router';
import {Injectable} from '@angular/core';
import {AuthenticationService} from '../_services/authentication.service';
import {Observable} from 'rxjs/internal/Observable';
import {ToastrService} from 'ngx-toastr';

@Injectable()
export class AuthGuard implements CanActivate {

  constructor(private _router: Router, private _authService: AuthenticationService, private toastr: ToastrService) {
  }

  canActivate(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> | Promise<boolean> | boolean {
    const allowedRoles = next.data.allowedRoles;
    const isAuthorized = this._authService.isAuthorized(allowedRoles);
    console.log(isAuthorized);

    if (this._authService.isAuntenticated()) {
      if (!isAuthorized) {
        this.toastr.warning('Unauthorized to access this page');
        this._router.dispose();
      }
      return isAuthorized;
    } else {
      this._router.navigate(['/login']);
      return false;
    }
  }

}
