import { RouterModule } from '@angular/router';
import { NgModule } from '@angular/core';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AppMainComponent } from './app.main.component';
import { ErrorComponent } from './components/error/error.component';
import { NotfoundComponent } from './components/notfound/notfound.component';
import { AccessComponent } from './components/access/access.component';
import { EmissionUnitComponent } from './components/emissionunit/emissionunitcomponent';
import { EmissionSegmentComponent } from './components/emissionsegment/emissionsegmentcomponent';
import { EmissionTypeComponent } from './components/emissiontype/emissiontypecomponent';
import { EmissionFactorComponent } from './components/emissionfactor/emissionfactorcomponent';
import { StationaryComponent } from './components/stationary/stationarycomponent';
import { MobileComponent } from './components/mobile/mobilecomponent';
import { TransportationComponent } from './components/transportation/transportationcomponent';
import { ElectricityComponent } from './components/electricity/electricitycomponent';
@NgModule({
    imports: [
        RouterModule.forRoot([
            {
                path: '', component: AppMainComponent,
                children: [
                    {path: '', component: EmissionFactorComponent},
                    {path: 'pages/emissionunit', component: EmissionUnitComponent},
                    {path: 'pages/emissionsegment', component: EmissionSegmentComponent},
                    {path: 'pages/emissiontype', component: EmissionTypeComponent},
                    {path: 'pages/emissionfactor', component: EmissionFactorComponent},
                    {path: 'pages/stationary', component: StationaryComponent},
                    {path: 'pages/mobile', component: MobileComponent},
                    {path: 'pages/transportation', component: TransportationComponent},
                    {path: 'pages/electricity', component: ElectricityComponent},
                ],
            },
            {path:'pages/error', component: ErrorComponent},
            {path:'pages/notfound', component: NotfoundComponent},
            {path:'pages/access', component: AccessComponent},
            {path: '**', redirectTo: 'pages/notfound'},
        ], {scrollPositionRestoration: 'enabled', anchorScrolling:'enabled'})
    ],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
