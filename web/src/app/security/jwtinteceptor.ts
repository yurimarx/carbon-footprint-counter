import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpEvent, HttpResponse, HttpRequest, HttpHandler } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {
  intercept(httpRequest: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    httpRequest = httpRequest.clone({
        setHeaders: {
            Authorization: `Basic X1NZU1RFTTpTWVM=`
        }
    });
    return next.handle(httpRequest);
  }
}



