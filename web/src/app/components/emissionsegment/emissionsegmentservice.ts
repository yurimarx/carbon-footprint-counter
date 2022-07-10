import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { EmissionSegment } from './emissionsegment';

@Injectable({
  providedIn: 'root'
})
export class EmissionSegmentService {

  private url = environment.host + 'emissionsegments';

  constructor(private http: HttpClient) { }

  public list(): Observable<EmissionSegment[]> {
    return this.http.get<EmissionSegment[]>(this.url).pipe(take(1));
  }

  public get(emissionSegmentId: number): Observable<EmissionSegment> {
    return this.http.get<EmissionSegment>(`${this.url}/${emissionSegmentId}`).pipe(take(1));
  }

  public delete(emissionSegmentId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${emissionSegmentId}`).pipe(take(1));
  }

  public save(emissionSegment: EmissionSegment): Observable<EmissionSegment> {
    return this.http.post<EmissionSegment>(`${this.url}`, emissionSegment).pipe(take(1));
  }

}
