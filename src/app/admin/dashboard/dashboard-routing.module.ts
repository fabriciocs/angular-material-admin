import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';

const routes: Routes = [
  {
    path: '',
    component: HomeComponent
}
];

@NgModule({
  imports: [RouterModule.forChild(routes)], MatCardModule, MatGridListModule,
  exports: [RouterModule]
})
export class DashboardRoutingModule { }
