import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [PrismaModule], // Modules dont ce module va dépendre (ici en gros on va utiliser le PrismaService dans notre UserService qui est dans le module Prisma donc ca va l'importer)
  controllers: [UsersController], // On liste ici les controllers de ce module
  providers: [UsersService], // Ici tous les services qu'on va utiliser dans ce module
})
export class UsersModule {}
