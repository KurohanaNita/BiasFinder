import { Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Module({
  providers: [PrismaService],
  exports: [PrismaService], // ici en gros on met les services qu'on va utiliser dans d'autres modules pour pouvoir les importer ailleurs
})
export class PrismaModule {}
