import {TranslateService} from '@ngx-translate/core';
import {Injectable} from '@angular/core';

@Injectable()
export class LanguageService {

  constructor(private _langService: TranslateService) {
    this._langService.addLangs(['id', 'en']);
    this._langService.setDefaultLang('en');
  }

  gantiBahasa(langId: string): void {
    this._langService.use(langId);
  }

  get bahasaDefault() {
    return this._langService.defaultLang;
  }
}
