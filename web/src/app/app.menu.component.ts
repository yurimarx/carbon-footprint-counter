import { Component, HostListener, OnDestroy, OnInit } from '@angular/core';
import { Subscription } from 'rxjs';
import { AppMainComponent } from './app.main.component';
import { FootprintTotals } from './components/FootprintTotals';
import { Totals } from './components/totals';
import { TotalsService } from './components/totalsservice';

@Component({
    selector: 'app-menu',
    template: `
        
        <div class="layout-menu-container">
            <ul class="layout-menu" role="menu" (keydown)="onKeydown($event)">
                <li app-menu class="layout-menuitem-category" *ngFor="let item of model; let i = index;" [item]="item" [index]="i" [root]="true" role="none">
                    <div class="layout-menuitem-root-text" [attr.aria-label]="item.label">{{item.label}}</div>
                    <ul role="menu">
                        <li app-menuitem *ngFor="let child of item.items" [item]="child" [index]="i" role="none"></li>
                    </ul>
                </li>
                <p-divider></p-divider>
                <div>
                    <b>CO2 Emissions: {{this.co2.toFixed(6)}}</b>
                </div>
                <br/>
                <div>
                    <b>CH4 Emissions: {{this.ch4.toFixed(6)}}</b>
                </div>
                <br/>
                <div>
                    <b>N2O Emissions: {{this.n2o.toFixed(6)}}</b>
                </div>
            </ul>
        </div>
    `
})
export class AppMenuComponent implements OnInit, OnDestroy {

    model: any[];

    co2 = 0;

    ch4 = 0;

    n2o = 0;

    totals: Totals;

    subscription: Subscription;

    constructor(public appMain: AppMainComponent,
                private totalsService: TotalsService,
                private footprintTotals: FootprintTotals) { }
    
    ngOnInit() {
        this.getTotals()

        this.subscription = this.footprintTotals.currentFootprintValues.subscribe(
        message => {
            this.co2 = Number(message.split('|')[0]);
            this.ch4 = Number(message.split('|')[1]);
            this.n2o = Number(message.split('|')[2]);
        })
        
        this.model = [
            {
                label: 'Footprint Events',
                items: [
                    {label: 'Stationary Combustion ', icon: 'pi pi-fw pi-sun', routerLink: ['/pages/stationary']},
                    {label: 'Mobile Combustion', icon: 'pi pi-fw pi-car', routerLink: ['/pages/mobile']},
                    {label: 'Transportation', icon: 'pi pi-fw pi-send', routerLink: ['/pages/transportation']},
                    {label: 'Purchased Electricity', icon: 'pi pi-fw pi-bolt', routerLink: ['/pages/electricity']},
                ]
            },
            {
                label: 'Emission Database',
                items: [
                    {label: 'Emission Unit', icon: 'pi pi-fw pi-user-edit', routerLink: ['/pages/emissionunit']},
                    {label: 'Emission Segment', icon: 'pi pi-fw pi-user-edit', routerLink: ['/pages/emissionsegment']},
                    {label: 'Emission Type', icon: 'pi pi-fw pi-user-edit', routerLink: ['/pages/emissiontype']},
                    {label: 'Emission Factor', icon: 'pi pi-fw pi-sliders-v', routerLink: ['/pages/emissionfactor']},
                ]
            }
        ];
    }

    onKeydown(event: KeyboardEvent) {
        const nodeElement = (<HTMLDivElement> event.target);
        if (event.code === 'Enter' || event.code === 'Space') {
            nodeElement.click();
            event.preventDefault();
        }
    }

    getTotals() {
        this.totalsService.getTotals().subscribe(
            response => {
                this.footprintTotals.changeFootprintValues(
                    response.co2 + '|' + response.ch4 + '|' + response.n2o);
            }
        );
    }

    ngOnDestroy(): void {
        this.subscription.unsubscribe();
    }

}
