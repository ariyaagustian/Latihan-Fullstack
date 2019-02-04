import { Component, Inject, OnInit, AfterViewInit } from '@angular/core';
import { LanguageService } from '../../_services/lang.service';
import { AuthenticationService } from '../../_services/authentication.service';
import { Router } from '@angular/router';
import { ListUrl, RoleIds } from '../../_auth/auth.model';
import { environment } from '../../../environments/environment';
import { DOCUMENT } from '@angular/common';
import { JwtHelperService } from '@auth0/angular-jwt';

@Component({
  selector: 'app-dashboard',
  templateUrl: './default-layout.component.html'
})
export class DefaultLayoutComponent implements OnInit {

  bendera: string;
  public navItems: any[] = [];
  public sidebarMinimized = true;
  public element: HTMLElement = document.body;
  private changes: MutationObserver;
  name: string = '';
  public basePath = environment.basePath;
  email: string = '';
  public roleIds: RoleIds = new RoleIds();
  viewIds: string[] = [];

  constructor(
    private bahasa: LanguageService,
    private _auth: AuthenticationService,
    private _router: Router,
    @Inject(DOCUMENT) private docGo: Document,
    private jwtHelper: JwtHelperService) {

    this.changes = new MutationObserver((mutations) => {
      this.sidebarMinimized = document.body.classList.contains('sidebar-minimized');
    });

    this.changes.observe(<Element>this.element, {
      attributes: true
    });
  }

  switchLanguage(language: string) {
    this.bahasa.gantiBahasa(language);
    this.bendera = language;
  }

  ngOnInit(): void {
    this._auth.getViewIds(+this._auth.currentUser.user.id).subscribe((resp:any)=>{
      this.viewIds = resp.body;
    })
    console.log(this.jwtHelper.tokenGetter());
    this.bendera = this.bahasa.bahasaDefault;
    this.email = this._auth.currentUser.user.email;
    this.name = this._auth.currentUser.user.name;
    console.log('Mapping URL FROM CONTAINERS Layout : ');
    this.roleIds.roleIds = this._auth.currentUser.user.listRoleId;
    // this._auth.getUrlResource(this._auth.currentUser.user_name).subscribe((response: any) => {
    //   console.log(response);
    //   if (response.status === 200) {
    //     const listUrlResource: ListUrl[] = response.body.listUrls;
    //     console.log('LIST URL RESOURCE ');
    //     console.log(response);
    //     console.log(listUrlResource);
    //     for (const listDivision of listUrlResource) {
    //       const data: ListUrl = listDivision;
    //       if (data.children.length <= 0) {
    //         // console.log('data ==> ');
    //         // console.log(data);
    //         data.children = null;
    //       }
    //       this.navItems.push(data);
    //     }
    //   }
    // }, error => {
    //   console.log('ERROR GET LIST URL RESOURCE ' + error.status);
    //   console.log(error);
    // });
    this._auth.getUrlByRole(this.roleIds).subscribe((response: any) => {
      console.log(response);
      if (response.status === 200) {
        console.log('Response List URL Resource :');
        console.log(response.body.menus.RESOURCE);
        // this.navItems.push(response.body.menus.REGISTRATION);
        const listUrlResource: ListUrl[] = response.body.menus.SUPPORTING_DEVICE;
        console.log('LIST URL RESOURCE ');
        console.log(listUrlResource);
        for (const listDivision of listUrlResource) {
          const data: ListUrl = listDivision;
          if (data.children.length <= 0) {
            data.children = null;
          } else {
            const listDivision2: ListUrl[] = data.children;
            for (const listDivisi2 of listDivision2) {
              const data2: ListUrl = listDivisi2;
              if (data2.children.length <= 0) {
                data2.children = null;
              } else {
                const listDivision3: ListUrl[] = data.children;
                for (const listDivisi3 of listDivision3) {
                  const data3: ListUrl = listDivisi3;
                  if (data3.children.length <= 0) {
                    data3.children = null;
                  }
                }
              }
            }
          }
          this.navItems.push(data);
        }
      }
    }, error => {
      if (this.jwtHelper.isTokenExpired) {
        document.getElementById('openSessionExpired').click();
      }
      console.log('ERROR GET LIST URL RESOURCE ' + error.status);
      console.log(error);
    });
    // console.log(this.navItems);
    // console.log('Remove Duplicates : ');
    // this.removeDuplicates(this.navItems);
    // this.navItems = navItems;
  }

  selectModule(module: string) {
    console.log(`Module Pilihan ${module}`);
    console.log(window.location.origin);
    this.docGo.location.href = window.location.origin + environment.siteUrl + module;
  }

  removeDuplicates(arr: ListUrl[]) {
    // let dupes = {};
    // const array= [
    //   {id:"1", name:"A", address:"A"},
    //   {id:"2", name:"A", address:"B"},
    //   {id:"3", name:"A", address:"C"},
    //   {id:"4", name:"B", address:"A"},
    //   {id:"5", name:"B", address:"B"},
    //   {id:"6", name:"C", address:"A"},
    //   {id:"7", name:"C", address:"B"},
    //   {id:"8", name:"A", address:"C"}];
    // array.forEach((item,index) => {
    //   dupes[item.name] = dupes[item.name] || [];
    //   dupes[item.name].push(index);
    // });
    // for(let name in dupes) console.log(name+'->indexes->'+dupes[name]+'->count->'+dupes[name].length)


    // var obj = {};
    // for (var i = 0, len = arr.length; i < len; i++)
    //   obj[arr[i]['id']] = arr[i];
    //
    // arr = new Array();
    // for (var key in obj)
    //   arr.push(obj[key]);
    //
    // console.log(arr);
    // this.navItems = arr;

  }

  keluar() {
    this._router.navigate(['logout']);
  }

  gotoRemys(module: string) {
    this.docGo.location.href = window.location.origin + module;
  }
}
