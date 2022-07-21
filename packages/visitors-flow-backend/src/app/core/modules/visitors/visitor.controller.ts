import { Controller, Get, Post, Body, Patch, Param } from '@nestjs/common';
import { CreateVisitorDTO } from './dto/create-visitor.dto';
import { UpdateVisitorDTO } from './dto/update-visitor.dto';
import { VisitorService } from './visitor.service';

@Controller('visitors')
export class VisitorController {

    constructor(private visitorService: VisitorService) {

    }
    
    @Get()
    async getAll() {
        return this.visitorService.getAll();
    }
    
    @Post()
    async create(@Body() visitor: CreateVisitorDTO) {
        return this.visitorService.create(visitor)
    }
    
    @Patch('/:id')
    async update(@Param('id') id: string, @Body() visitor: UpdateVisitorDTO) {
        return this.visitorService.findByIdAndUpdate(id, visitor)
    }
}
