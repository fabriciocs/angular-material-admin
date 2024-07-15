import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { GridComponent } from './grid/grid.component';

const routes: Routes = [
  {
    path: '',
    component: GridComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)], MatCardModule, MatGridListModule,
  exports: [RouterModule]
})
export class MatGridRoutingModule {}
