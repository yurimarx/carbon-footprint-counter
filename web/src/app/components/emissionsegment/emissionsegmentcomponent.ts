import { Component, OnInit } from '@angular/core';
import { ConfirmationService, MessageService } from 'primeng/api';
import { EmissionSegment } from './emissionsegment';
import { EmissionSegmentService } from './emissionsegmentservice';

@Component({
    templateUrl: './emissionsegment.html',
    providers: [MessageService, ConfirmationService],
    styleUrls: ['../../../assets/demo/badges.scss']
})
export class EmissionSegmentComponent implements OnInit {

    emissionSegmentDialog: boolean;

    deleteEmissionSegmentDialog: boolean = false;

    emissionSegments: EmissionSegment[];

    emissionSegment: EmissionSegment;

    submitted: boolean;

    cols: any[];

    statuses: any[];

    rowsPerPageOptions = [5, 10, 20];

    constructor(private emissionSegmentService: EmissionSegmentService, private messageService: MessageService,
                private confirmationService: ConfirmationService) {}

    ngOnInit() {
        this.list()

        this.cols = [
            {field: 'name', header: 'Name'},
            {field: 'description', header: 'Description'}
        ];

    }

    list() {
        this.emissionSegmentService.list().subscribe(
            response => {
                this.emissionSegments = response
            }
        );
    }

    openNew() {
        this.emissionSegment = new EmissionSegment();
        this.submitted = false;
        this.emissionSegmentDialog = true;
    }

    editEmissionSegment(emissionSegment: EmissionSegment) {
        this.emissionSegment = emissionSegment;
        this.emissionSegmentDialog = true;
    }

    deleteEmissionSegment(emissionSegment: EmissionSegment) {
        this.deleteEmissionSegmentDialog = true;
        this.emissionSegment = {...emissionSegment};
    }

    confirmDelete(){
        
        this.emissionSegmentService.delete(this.emissionSegment.emissionSegmentId).subscribe(
            () => {
                this.emissionSegment = new EmissionSegment()
                this.deleteEmissionSegmentDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Unit Deleted', life: 3000});
                this.emissionSegment = new EmissionSegment();
                this.list()
            }
        );
        
        
    }

    hideDialog() {
        this.emissionSegmentDialog = false;
        this.submitted = false;
    }

    saveEmissionSegment() {
        this.submitted = true;

        this.emissionSegmentService.save(this.emissionSegment).subscribe(
            response => {
                this.emissionSegment = response
                this.emissionSegmentDialog = false;
                this.messageService.add({severity: 'success', summary: 'Successful', detail: 'Emission Unit saved', life: 3000});
                this.list()
            }
        );

    }
    
}
