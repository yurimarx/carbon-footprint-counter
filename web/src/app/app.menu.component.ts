import { Component, OnInit } from '@angular/core';
import { AppMainComponent } from './app.main.component';

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
            </ul>
        </div>
    `
})
export class AppMenuComponent implements OnInit {

    model: any[];

    constructor(public appMain: AppMainComponent) { }

    ngOnInit() {
        this.model = [
            {
                label: 'Footprint Calculator',
                items: [
                    {label: 'Stationary Combustion', icon: 'pi pi-fw pi-sun', routerLink: ['/pages/stationary']},
                    {label: 'Mobile Combustion', icon: 'pi pi-fw pi-car', routerLink: ['/pages/mobile']},
                    {label: 'Transportation', icon: 'pi pi-fw pi-send', routerLink: ['/pages/emissiontype']},
                    {label: 'Purchased Electricity', icon: 'pi pi-fw pi-bolt', routerLink: ['/pages/emissionfactor']},
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
}
