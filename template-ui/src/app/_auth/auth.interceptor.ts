import {HttpErrorResponse, HttpHandler, HttpHeaders, HttpInterceptor, HttpRequest} from '@angular/common/http';
import {Injectable} from '@angular/core';
import {AuthenticationService} from '../_services/authentication.service';
import {Router} from '@angular/router';
import {ToastrService} from 'ngx-toastr';
import {catchError} from 'rxjs/operators';
import {Observable} from 'rxjs';

@Injectable()
export class AuthenticationInterceptor implements HttpInterceptor {

  constructor(private _authService: AuthenticationService, private _router: Router, private _toastr: ToastrService) {
  }

  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<any> {
    let headers = new HttpHeaders();
    const urlBased = req.url;
    // console.log(`link : ${urlBased}`);

    if (this._authService.currentUser) {
      headers = headers.append('Authorization', `Bearer ${this._authService.currentUser.access_token}`);
      // language=RegExp
      if (!urlBased.match('\/(login\/alfresco|alfresco)\/[a-zA-Z0-9.?=&&_-]*')) {
        const newRequest = req.clone({
          headers: headers
        });
        // console.log('auth backend');
        return next.handle(newRequest).pipe(catchError(err => {
          if (err instanceof HttpErrorResponse) {
            if (err.status === 401) {
              this._authService.checkToken(this._authService.currentUser.access_token).subscribe((resp: any) => {
                this._authService.logout().subscribe((resp: any) => {
                  this._toastr.warning('Please Login', 'Session has Expired');
                  localStorage.removeItem('currentUser');
                  localStorage.removeItem('k01mNd912mHDasd123ccQOdp');
                  this._router.navigate(['login']);
                });
              }, error => {
                this._toastr.warning('Please Login', 'Session has Expired');
                localStorage.removeItem('currentUser');
                localStorage.removeItem('k01mNd912mHDasd123ccQOdp');
                this._router.navigate(['login']);
              });
              return Observable.throw(err);
            }
            return Observable.throw(err);
          }
        }));
      } else {
        const newRequest = req.clone();
        // console.log('auth alfresco');
        return next.handle(newRequest);
      }
    } else {
      const newRequest = req.clone();
      // console.log('auth false');
      return next.handle(newRequest);
    }
  }
}
