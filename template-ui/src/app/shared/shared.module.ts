import {NgModule} from '@angular/core';
import {AllCharDirective, NumberOnlyDirective, NumberSymbolDirective, TextOnlyDirective} from '../directives/directives';

@NgModule({
  declarations: [NumberOnlyDirective, TextOnlyDirective, AllCharDirective, NumberSymbolDirective],
  exports: [NumberOnlyDirective, TextOnlyDirective, AllCharDirective, NumberSymbolDirective]
})
export class SharedModule {
}
