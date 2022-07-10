import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from 'src/environments/environment';
import { take } from 'rxjs/operators';
import { EmissionType } from './emissiontype';

@Injectable({
  providedIn: 'root'
})
export class EmissionTypeService {

  private url = environment.host + 'emissiontypes';

  constructor(private http: HttpClient) { }

  public list(): Observable<EmissionType[]> {
    return this.http.get<EmissionType[]>(this.url).pipe(take(1));
  }

  public get(emissionTypeId: number): Observable<EmissionType> {
    return this.http.get<EmissionType>(`${this.url}/${emissionTypeId}`).pipe(take(1));
  }

  public delete(emissionTypeId: number): Observable<any> {
    return this.http.delete<any>(`${this.url}/${emissionTypeId}`).pipe(take(1));
  }

  public save(emissionType: EmissionType): Observable<EmissionType> {
    return this.http.post<EmissionType>(`${this.url}`, emissionType).pipe(take(1));
  }

}
