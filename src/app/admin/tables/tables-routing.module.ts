import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { TablesComponent } from './tables/tables.component';

const routes: Routes = [
  {
    path: '',
    component: TablesComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)], MatCardModule, MatGridListModule,
  exports: [RouterModule]
})
export class TablesRoutingModule {}
