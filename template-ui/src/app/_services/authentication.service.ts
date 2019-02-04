import {Authentication, CurrentUser, RoleIds, Token} from '../_auth/auth.model';
import {Injectable, OnInit} from '@angular/core';
import {HttpClient, HttpHeaders, HttpParams} from '@angular/common/http';
import {environment} from '../../environments/environment';
import {JwtHelperService} from '@auth0/angular-jwt';

@Injectable()
export class AuthenticationService implements OnInit {

  private currentLogin = 'currentUser';
  jwtHelperService: JwtHelperService = new JwtHelperService();

  // jwtHelper: JwtHelper = new JwtHelper();

  ngOnInit(): void {
  }

  constructor(private _http: HttpClient) {
  }

  public permittedViewIds = 'viewIds';

  isAuntenticated(): boolean {
    return localStorage.getItem(this.currentLogin) != null;
  }

  logout() {
    console.log('Logout Service : ');
    let params = new HttpParams();
    params = params.set('user', this.currentUser.user.loginId);
    const body = {token: this.currentUser.access_token};
    console.log(body);
    return this._http.post(`${environment.authLogout}/oauth/revoke`, {token: this.currentUser.access_token}, {
      observe: 'response',
      params: params
    });
  }

  // logoutWithoutRevoke() {
  //   console.log('Logout Service : ');
  //   let params = new HttpParams();
  //   params = params.set('user', this.currentUser.user.loginId);
  //   const body = { token: this.currentUser.access_token }
  //   console.log(body);
  //   return this._http.post(`${environment.authLogout}/oauth/revoke`,
  //   { token: this.currentUser.access_token }, { observe: 'response', params: params });
  // }

  get currentUser(): CurrentUser {
    const currentLogin: CurrentUser = JSON.parse(this.isAuntenticated() ? localStorage.getItem(this.currentLogin) : null);
    return currentLogin;
  }

  get viewIds(): string[] {
    const viewIds: string[] = JSON.parse(localStorage.getItem('viewIds'));
    return viewIds;
  }

  setToken(token: Token): void {
    const login: CurrentUser = this.jwtHelperService.decodeToken(token.access_token);
    login.access_token = token.access_token;
    login.expired = this.jwtHelperService.isTokenExpired(token.access_token);

    localStorage.setItem(this.currentLogin, JSON.stringify(login));
  }

  authenticate(auth: Authentication) {
    let params = new HttpParams();
    params = params.set('username', auth.username);
    params = params.set('password', auth.password);
    params = params.set('client_id', environment.clientId);
    params = params.set('grant_type', 'password');

    let headers = new HttpHeaders();
    headers = headers.set('Authorization', `Basic ${btoa(environment.clientId + ':' + environment.clientSecret)}`);
    headers = headers.set('Content-Type', 'application/json');
    return this._http.post<Token>(
      environment.authUri, {}, {headers: headers, params: params}
    );
  }

  // get URL
  public getUrlResource(email: string) {
    let params = new HttpParams();
    params = params.set('email', email.toString());
    return this._http.get(`${environment.securityUri}/user-role-url-resource/list-url-resource-by-email`, {
      observe: 'response',
      params: params
    });
  }

  public getUrlByRole(roleIds: RoleIds) {
    console.log('Roles ID Send Body :');
    console.log(roleIds);
    return this._http.post(`${environment.securityMenu}/inquiry/byRole`, roleIds, {observe: 'response'});
  }

  public checkToken(token: string) {
    let params = new HttpParams();
    params = params.append('token', token.toString());
    console.log(params);
    return this._http.get(`${environment.checkToken}`, {observe: 'response', params: params});
  }

  public getViewIds(id: number) {
    return this._http.get(`${environment.securityUri}/component-menu/view-ids/${id}`, {observe: 'response'});
  }

  isAuthorized(allowedRoles: string[]): boolean {
    if (allowedRoles == null || allowedRoles.length === 0) {
      return true;
    }

    console.log(localStorage.getItem(this.permittedViewIds));

    return allowedRoles.some(r => localStorage.getItem(this.permittedViewIds).includes(r));
  }

  public remysLogin(token: string) {
    const params = new HttpParams().set('token', token);
    return this._http.get(`${environment.remysUri}/login.rest`, {params: params});
  }

  remysLogout() {
    let headers = new HttpHeaders();
    headers = headers.set('Content-Type', 'text/plain');
    headers = headers.set('Cookie', 'JSESSIONID={VALUE_JSESSIONID}');
    return this._http.get(
      `${environment.remysUri}/logout.rest`, {headers: headers}
    );
  }

}
