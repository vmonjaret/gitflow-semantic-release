import { NestFactory } from '@nestjs/core';
import * as apm from 'elastic-apm-node';
import { AppModule } from './app.module';

async function bootstrap() {
  apm.start({
    serverUrl: 'http://apm.local',
    environment: 'local',
  });

  const app = await NestFactory.create(AppModule);
  await app.listen(3000);
}
bootstrap();
