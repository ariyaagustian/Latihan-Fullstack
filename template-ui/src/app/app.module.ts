import {PerfectScrollbarConfigInterface, PerfectScrollbarModule} from 'ngx-perfect-scrollbar';
import {environment} from '../environments/environment';
import {DefaultLayoutComponent} from './containers/default-layout';
import {LoginComponent} from './views/login/login.component';
import {LogoutComponent} from './views/logout/logout.component';
import {HttpClient, HttpClientModule} from '@angular/common/http';
import {TranslateHttpLoader} from '@ngx-translate/http-loader';
import {NgModule} from '@angular/core';
import {AlertModule, BsDropdownModule, CollapseModule, ModalModule, PopoverModule, TabsModule, TooltipModule} from 'ngx-bootstrap';
import {CalendarModule} from 'angular-calendar';
import {NgbModalModule} from '@ng-bootstrap/ng-bootstrap';
import {FlatpickrModule} from 'angularx-flatpickr';
import {BrowserModule} from '@angular/platform-browser';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {Ng4LoadingSpinnerModule} from 'ng4-loading-spinner';
import {DataTablesModule} from 'angular-datatables';
import {ReactiveFormsModule} from '@angular/forms';
import {ToastContainerModule, ToastrModule} from 'ngx-toastr';
import {TranslateLoader, TranslateModule, TranslateService} from '@ngx-translate/core';
import {AppRoutingModule} from './app.routing';
import {AngularMultiSelectModule} from 'angular2-multiselect-dropdown';
import {AppAsideModule, AppBreadcrumbModule, AppFooterModule, AppHeaderModule, AppSidebarModule} from '@coreui/angular';
import {NgSelectModule} from '@ng-select/ng-select';
import {SharedModule} from './shared/shared.module';
import {JwtModule} from '@auth0/angular-jwt';
import {AppComponent} from './app.component';
import {HashLocationStrategy, LocationStrategy} from '@angular/common';
import {AuthGuard} from './_auth/auth.guard';
import {LanguageService} from './_services/lang.service';
import {AuthenticationService} from './_services/authentication.service';
import {RoutingStateService} from './_services/routing-state.service';
import {CookieService} from 'ngx-cookie-service';
import {DashboardModule} from './views/dashboard/dashboard.module';
import {MasterModule} from './views/master/master.module';

const DEFAULT_PERFECT_SCROLLBAR_CONFIG: PerfectScrollbarConfigInterface = {
  suppressScrollX: true
};

const basePath = environment.basePath;

const APP_CONTAINERS = [
  DefaultLayoutComponent,
  LoginComponent,
  LogoutComponent
];

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http);
}

export function tokenGetter() {
  return localStorage.getItem('access_token');
}

@NgModule({
  imports: [
    CollapseModule.forRoot(),
    CalendarModule.forRoot(),
    NgbModalModule.forRoot(),
    FlatpickrModule.forRoot(),
    BrowserModule,
    BrowserAnimationsModule,
    AlertModule.forRoot(),
    ModalModule.forRoot(),
    Ng4LoadingSpinnerModule.forRoot(),
    DataTablesModule,
    ReactiveFormsModule,
    ToastrModule.forRoot({
      timeOut: 4000,
      positionClass: 'toast-top-center',
      preventDuplicates: true,
      closeButton: true,
      tapToDismiss: true
    }),
    ToastContainerModule,
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: HttpLoaderFactory,
        deps: [HttpClient]
      }
    }),
    HttpClientModule,
    AppRoutingModule,
    AngularMultiSelectModule,
    AppAsideModule,
    AppBreadcrumbModule.forRoot(),
    PopoverModule.forRoot(),
    AppFooterModule,
    AppHeaderModule,
    AppSidebarModule,
    PerfectScrollbarModule,
    BsDropdownModule.forRoot(),
    TabsModule.forRoot(),
    TooltipModule.forRoot(),
    NgSelectModule,
    SharedModule,
    JwtModule.forRoot({
      config: {
        tokenGetter: tokenGetter,
        whitelistedDomains: ['localhost:3001'],
        blacklistedRoutes: ['localhost:3001/auth/']
      }
    }),
    DashboardModule,
    MasterModule
  ],
  declarations: [AppComponent, ...APP_CONTAINERS],
  providers: [
    {
      provide: LocationStrategy,
      useClass: HashLocationStrategy
    },
    AuthGuard,
    AuthenticationService,
    TranslateService,
    LanguageService,
    RoutingStateService,
    CookieService
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
