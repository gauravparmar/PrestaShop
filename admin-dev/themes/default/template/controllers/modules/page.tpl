{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{include file='controllers/modules/top.tpl'}

{if $add_permission eq '1'}
<div id="module_install" class="row" style="{if !isset($smarty.post.downloadflag)}display: none;{/if}">

	<div class="panel col-lg-12">
		<form action="{$currentIndex}&token={$token}" method="post" enctype="multipart/form-data" class="form-horizontal">
			<h3>{l s='Add a new module'}</h3>
			<p class="alert alert-info">{l s='The module must either be a zip file or a tarball.'}</p>
			<div class="form-group">
				<label for="file" class="control-label col-lg-3">
					<span class="label-tooltip" data-toggle="tooltip" title="{l s='Upload a module from your computer.'}">
						{l s='Module file'}
					</span>
				</label>
				<div class="col-lg-9">
					<div class="row">
						<div class="col-lg-7">
							<input id="file" type="file" name="file" class="hide" />
							<div class="dummyfile input-group">
								<span class="input-group-addon"><i class="icon-file"></i></span>
								<input id="file-name" type="text" class="disabled" name="filename" readonly />
								<span class="input-group-btn">
									<button id="file-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
										<i class="icon-folder-open"></i> {l s='Choose a file'}
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-9 col-lg-push-3">
					<button class="btn btn-default" type="submit" name="download">
						<i class="icon-upload-alt" ></i>
						{l s='Upload this module'}
					</button>
				</div>
			</div>
		</form>
	</div>
</div>
{/if}

{if $upgrade_available|@count}
<div class="alert alert-info">
	{l s='An upgrade is available for some of your modules!'}
	<ul>
	{foreach from=$upgrade_available item='module'}
		<li> &raquo; <a href="{$currentIndex|escape:'html':'UTF-8'}&token={$token|escape:'html':'UTF-8'}&anchor=anchor{$module.anchor|escape:'html':'UTF-8'}"><b>{$module.name|escape:'html':'UTF-8'}</b></a></li>
	{/foreach}
	</ul>
</div>
{/if}
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-list-ul"></i>
			{l s='Modules list'}
		</div>
		<!--start sidebar module-->
		<div class="row">
			<div class="categoriesTitle col-lg-3">
				<div class="list-group">
					<form id="filternameForm" method="post" class="list-group-item form-horizontal">
						<div class="input-group">
							<input class="form-control" placeholder="{l s='Search'}" type="text" value="" name="moduleQuicksearch" id="moduleQuicksearch" autocomplete="off" />
							<div class="input-group-addon">
								<i class="icon-search"></i>
							</div>
						</div>
					</form>
					<a class="categoryModuleFilterLink list-group-item {if isset($categoryFiltered.favorites)}active{/if}" href="{$currentIndex}&token={$token}&filterCategory=favorites">
						{l s='Favorites'} <span id="favorite-count" class="badge pull-right">{$nb_modules_favorites}</span>
					</a>
					<a class="categoryModuleFilterLink list-group-item {if count($categoryFiltered) lte 0}active{/if}" href="{$currentIndex}&token={$token}&unfilterCategory=yes">
						{l s='All'} <span class="badge pull-right">{$nb_modules}</span>
					</a>
					{foreach from=$list_modules_categories item=module_category key=module_category_key}
						<a class="categoryModuleFilterLink list-group-item {if isset($categoryFiltered[$module_category_key])}active{/if}" href="{$currentIndex}&token={$token}&{if isset($categoryFiltered[$module_category_key])}un{/if}filterCategory={$module_category_key}">
							{$module_category.name} <span class="badge pull-right">{$module_category.nb}</span>
						</a>
					{/foreach}
				</div>
				{include file='controllers/modules/login_addons.tpl'}
			</div>
			<div id="moduleContainer" class="col-lg-9">
				{include file='controllers/modules/list.tpl'}
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$('#file-selectbutton').click(function(e){
			$('#file').trigger('click');
		});
		$('#file-name').click(function(e){
			$('#file').trigger('click');
		});
		$('#file').change(function(e){
			var val = $(this).val();
			var file = val.split(/[\\/]/);
			$('#file-name').val(file[file.length-1]);
		});
	});
</script>